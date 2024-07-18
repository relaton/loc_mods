# frozen_string_literal: true

module LocMods
  # ComparableMapper module provides functionality to compare and diff two objects
  # of the same class, based on their attribute values.
  module ComparableMapper
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Checks if two objects are equal based on their attributes
    # @param other [Object] The object to compare with
    # @return [Boolean] True if objects are equal, false otherwise
    def eql?(other)
      other.class == self.class &&
        self.class.attributes.all? { |attr, _| send(attr) == other.send(attr) }
    end

    alias == eql?

    # Generates a hash value for the object
    # @return [Integer] The hash value
    def hash
      ([self.class] + self.class.attributes.map { |attr, _| send(attr).hash }).hash
    end

    # Class methods added to the class that includes ComparableMapper
    module ClassMethods
      # Generates a diff tree between two objects of the same class
      # @param obj1 [Object] The first object to compare
      # @param obj2 [Object] The second object to compare
      # @param options [Hash] Options for diff generation
      # @return [String] A string representation of the diff tree
      def diff_tree
        if @obj1.nil? && @obj2.nil?
          @root_tree = Tree.new("Both objects are nil")
        elsif @obj1.nil?
          @root_tree = Tree.new("First object is nil")
          format_single_value(@obj2, @root_tree, @obj2.class.to_s)
        elsif @obj2.nil?
          @root_tree = Tree.new("Second object is nil")
          format_single_value(@obj1, @root_tree, @obj1.class.to_s)
        else
          traverse_diff do |name, type, value1, value2, is_last|
            format_attribute_diff(name, type, value1, value2, is_last)
          end
        end
        @root_tree.to_s
      end

      # Generates a diff tree and calculates a diff score between two objects of the same class
      # @param obj1 [Object] The first object to compare
      # @param obj2 [Object] The second object to compare
      # @param options [Hash] Options for diff generation
      # @return [Array<Float, String>] An array containing the normalized diff score and the diff tree
      def diff_with_score(obj1, obj2, **options)
        context = DiffContext.new(obj1, obj2, **options)
        [context.calculate_diff_score, context.diff_tree]
      end
    end

    class Tree
      attr_accessor :content, :children, :color

      def initialize(content, color: nil)
        @content = content
        @children = []
        @color = color
      end

      def add_child(child)
        @children << child
      end

      def to_s(indent = "", is_last = true)
        prefix = is_last ? "└── " : "├── "
        result = "#{indent}#{colorize(prefix + @content, @color)}\n"
        @children.each_with_index do |child, index|
          is_last_child = index == @children.size - 1
          child_indent = indent + (is_last ? "    " : "#{colorize("│", @color)}   ")
          result += child.to_s(child_indent, is_last_child)
        end
        result
      end

      private

      def colorize(text, color)
        return text unless color
        color_codes = { red: 31, green: 32, blue: 34 }
        "\e[#{color_codes[color]}m#{text}\e[0m"
      end
    end

    # DiffContext handles the comparison between two objects
    class DiffContext
      attr_reader :obj1, :obj2, :show_unchanged, :highlight_diff, :use_colors
      attr_accessor :level, :tree_lines, :root_tree

      # Initializes a new DiffContext
      # @param obj1 [Object] The first object to compare
      # @param obj2 [Object] The second object to compare
      # @param options [Hash] Options for diff generation
      def initialize(obj1, obj2, **options)
        @obj1, @obj2 = obj1, obj2
        @show_unchanged = options.fetch(:show_unchanged, false)
        @highlight_diff = options.fetch(:highlight_diff, false)
        @use_colors = options.fetch(:use_colors, true)
        @level = 0
        @tree_lines = []
        @root_tree = Tree.new(obj1.class.to_s)
      end

      # Generates a diff tree between the two objects
      # @return [String] A string representation of the diff tree
      def diff_tree
        traverse_diff do |name, type, value1, value2, is_last|
          format_attribute_diff(name, type, value1, value2, is_last)
        end
        @root_tree.to_s
      end

      # Calculates the normalized diff score
      # @return [Float] The normalized diff score
      def calculate_diff_score
        total_score, total_attributes = 0, 0
        traverse_diff do |_, _, value1, value2, _|
          total_score += calculate_attribute_score(value1, value2)
          total_attributes += 1
        end
        total_attributes > 0 ? total_score / total_attributes : 0
      end

      private

      # Applies color to text if colors are enabled
      # @param text [String] The text to color
      # @param color [Symbol] The color to apply
      # @return [String] The colored text
      def colorize(text, color)
        return text unless @use_colors
        color_codes = { red: 31, green: 32, blue: 34 }
        "\e[#{color_codes[color]}m#{text}\e[0m"
      end

      # Traverses the attributes of the objects and yields each attribute's details
      # @yield [String, Symbol, Object, Object, Boolean] Yields the name, type, value1, value2, and is_last for each attribute
      def traverse_diff
        return yield nil, nil, obj1, obj2, true if obj1.class != obj2.class

        obj1.class.attributes.each_with_index do |(name, type), index|
          yield name, type, obj1.send(name), obj2.send(name), index == obj1.class.attributes.length - 1
        end
      end

      # Generates the prefix for tree lines
      # @return [String] Prefix for tree lines
      def tree_prefix
        @tree_lines.map { |enabled| enabled ? "│   " : "    " }.join
      end

      # Formats a line in the tree structure
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param content [String] The content to be displayed in the line
      # @return [String] Formatted tree line
      def tree_line(is_last, content)
        "#{tree_prefix}#{is_last ? "└── " : "├── "}#{content}\n"
      end

      # Calculates the diff score for a single attribute
      # @param value1 [Object] The value of the attribute in the first object
      # @param value2 [Object] The value of the attribute in the second object
      # @return [Float] The diff score for the attribute
      def calculate_attribute_score(value1, value2)
        if value1 == value2
          0
        elsif value1.is_a?(Array) && value2.is_a?(Array)
          calculate_array_score(value1, value2)
        else
          value1.class == value2.class ? 0.5 : 1
        end
      end

      # Calculates the diff score for array attributes
      # @param arr1 [Array] The array from the first object
      # @param arr2 [Array] The array from the second object
      # @return [Float] The diff score for the arrays
      def calculate_array_score(arr1, arr2)
        max_length = [arr1.length, arr2.length].max
        return 0.0 if max_length.zero?

        total_score = max_length.times.sum do |i|
          if i < arr1.length && i < arr2.length
            if arr1[i] == arr2[i]
              0.0
            elsif arr1[i].is_a?(ComparableMapper) && arr2[i].is_a?(ComparableMapper)
              DiffContext.new(arr1[i], arr2[i], show_unchanged: @show_unchanged).calculate_diff_score
            else
              calculate_attribute_score(arr1[i], arr2[i])
            end
          else
            1.0
          end
        end

        total_score / max_length
      end

      # Formats a value for display in the diff output
      # @param value [Object] The value to format
      # @return [String] Formatted value
      def format_value(value)
        case value
        when nil then "(nil)"
        when String then "(String) \"#{value}\""
        when Array
          if value.empty?
            "(Array) 0 items"
          else
            items = value.map { |item| format_value(item) }.join(", ")
            "(Array) [#{items}]"
          end
        when Hash then "(Hash) #{value.keys.length} keys"
        when ComparableMapper then "(#{value.class})"
        else "(#{value.class}) #{value}"
        end
      end

      # Formats the diff output for a single attribute
      # @param name [String] The name of the attribute
      # @param type [Symbol] The type of the attribute
      # @param value1 [Object] The value of the attribute in the first object
      # @param value2 [Object] The value of the attribute in the second object
      # @param is_last [Boolean] Whether this is the last attribute in the list
      # @return [String] Formatted diff output for the attribute
      def format_attribute_diff(name, type, value1, value2, is_last)
        return if value1 == value2 && !@show_unchanged

        node = Tree.new("#{name} (#{obj1.class.attributes[name].collection? ? "collection" : type_name(type)}):")
        @root_tree.add_child(node)

        if obj1.class.attributes[name].collection?
          format_collection(value1, value2, node)
        elsif value1 == value2
          format_single_value(value1, node, "")
        else
          format_value_tree(value1, value2, node, "", type_name(type))
        end
      end

      # Formats a collection (array) for diff output
      # @param array1 [Array] The first array to compare
      # @param array2 [Array] The second array to compare
      # @return [String] Formatted diff output for the collection
      def format_collection(array1, array2, parent_node)
        array2 = [] if array2.nil?
        max_length = [array1.length, array2.length].max

        if max_length == 0
          parent_node.content += " (nil)"
          return
        end

        max_length.times do |index|
          item1 = array1[index]
          item2 = array2[index]

          if item1 == item2
            format_single_value(item1, parent_node, "[#{index + 1}] (#{type_name(item1.class)})") if @show_unchanged
          else
            prefix = item2.nil? ? "- " : (item1.nil? ? "+ " : "")
            node = Tree.new("#{prefix}[#{index + 1}] (#{type_name(item1&.class || item2&.class)})", color: item2.nil? ? :red : (item1.nil? ? :green : nil))
            parent_node.add_child(node)
            if item1.nil?
              format_diff_item(item2, :green, node)
            elsif item2.nil?
              format_diff_item(item1, :red, node)
            else
              format_value_tree(item1, item2, node, "")
            end
          end
        end
      end

      # Formats a removed item in the diff output
      # @param item [Object] The removed item
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param index [Integer] The index of the removed item
      # @return [String] Formatted output for the removed item
      def format_removed_item(item, parent_node)
        format_diff_item(item, :red)
      end

      # Formats an added item in the diff output
      # @param item [Object] The added item
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param index [Integer] The index of the added item
      # @return [String] Formatted output for the added item
      def format_added_item(item, parent_node)
        format_diff_item(item, :green)
      end

      # Formats a diff item (added or removed)
      # @param item [Object] The item to format
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param index [Integer] The index of the item
      # @param color [Symbol] The color to use for the item
      # @param prefix [String] The prefix to use for the item (+ or -)
      # @return [String] Formatted output for the diff item
      def format_diff_item(item, color, parent_node)
        if item.is_a?(ComparableMapper)
          format_comparable_mapper(item, parent_node, color)
        else
          parent_node.add_child(Tree.new(format_value(item), color: color))
        end
      end

      # Formats the content of an object for diff output
      # @param obj [Object] The object to format
      # @return [String] Formatted content of the object
      def format_object_content(obj)
        if obj.is_a?(ComparableMapper)
          obj.class.attributes.map { |attr, _| "#{attr}: #{format_value(obj.send(attr))}" }.join("\n")
        else
          format_value(obj)
        end
      end

      # Formats and colors the content for diff output
      # @param content [String] The content to format and color
      # @param color [Symbol] The color to apply
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @return [String] Formatted and colored content
      def format_colored_content(content, color, is_last)
        lines = content.split("\n")
        lines.map.with_index do |line, index|
          if index == 0
            "" # Skip the first line as it's already been output
          else
            prefix = index == lines.length - 1 && is_last ? "└── " : "├── "
            tree_line(index == lines.length - 1 && is_last, colorize("#{prefix}#{line}", color))
          end
        end.join
      end

      # Gets the name of a type
      # @param type [Class, Object] The type to get the name for
      # @return [String] The name of the type
      def type_name(type)
        if type.is_a?(Class)
          type.name
        elsif type.respond_to?(:type)
          type.type.name
        else
          type.class.name
        end
      end

      # Formats the attributes of an object for diff output
      # @param obj1 [Object] The first object
      # @param obj2 [Object] The second object
      # @return [String] Formatted attributes of the objects
      def format_object_attributes(obj1, obj2, parent_node)
        obj1.class.attributes.each do |attr, _|
          value1 = obj1.send(attr)
          value2 = obj2 ? obj2.send(attr) : nil

          attr_type = obj1.class.attributes[attr].collection? ? "collection" : type_name(obj1.class.attributes[attr])

          if value1 == value2
            format_single_value(value1, parent_node, "#{attr} (#{attr_type})") if @show_unchanged
          else
            format_value_tree(value1, value2, parent_node, attr, attr_type)
          end
        end
      end

      # Formats the value tree for diff output
      # @param value1 [Object] The first value
      # @param value2 [Object] The second value
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param label [String] The label for the value
      # @param type_info [String, nil] Additional type information
      # @return [String] Formatted value tree
      def format_value_tree(value1, value2, parent_node, label, type_info = nil)
        if value1 == value2
          return if @highlight_diff
          return format_single_value(value1, parent_node, "#{label}#{type_info ? " (#{type_info})" : ""}") if @show_unchanged
          return
        end

        case value1
        when Array
          format_collection(value1, value2, parent_node)
        when Hash
          format_hash_tree(value1, value2, parent_node)
        when ComparableMapper
          format_object_attributes(value1, value2, parent_node)
        else
          node = Tree.new("#{label}#{type_info ? " (#{type_info})" : ""}:")
          parent_node.add_child(node)
          node.add_child(Tree.new("- #{format_value(value1)}", color: :red))
          node.add_child(Tree.new("+ #{format_value(value2)}", color: :green))
        end
      end

      # Formats a single value for diff output
      # @param value [Object] The value to format
      # @param is_last [Boolean] Whether this is the last item in the current level
      # @param label [String] The label for the value
      # @return [String] Formatted single value
      def format_single_value(value, parent_node, label, color = nil)
        node = Tree.new("#{label}#{label.empty? ? "" : ":"}", color: color)
        parent_node.add_child(node)

        case value
        when ComparableMapper
          format_comparable_mapper(value, node, color)
        when Array
          if value.empty?
            node.add_child(Tree.new("(nil)", color: color))
          else
            format_collection(value, value, node)
          end
        else
          node.content += " #{format_value(value)}"
        end
      end

      # Formats a ComparableMapper object for diff output
      # @param obj [ComparableMapper] The object to format
      # @return [String] Formatted ComparableMapper object
      def format_comparable_mapper(obj, parent_node, color = nil)
        obj.class.attributes.each do |attr_name, attr_type|
          attr_value = obj.send(attr_name)
          attr_node = Tree.new("#{attr_name} (#{type_name(attr_type)}):", color: color)
          parent_node.add_child(attr_node)
          if attr_value.is_a?(ComparableMapper)
            format_comparable_mapper(attr_value, attr_node, color)
          else
            value_node = Tree.new(format_value(attr_value), color: color)
            attr_node.add_child(value_node)
          end
        end
      end

      # Formats a hash tree for diff output
      # @param hash1 [Hash] The first hash to compare
      # @param hash2 [Hash] The second hash to compare
      # @return [String] Formatted hash tree
      def format_hash_tree(hash1, hash2, parent_node)
        keys = (hash1.keys + hash2.keys).uniq
        keys.each do |key|
          value1 = hash1[key]
          value2 = hash2[key]

          if value1 == value2
            format_single_value(value1, parent_node, key) if @show_unchanged
          else
            format_value_tree(value1, value2, parent_node, key)
          end
        end
      end
    end
  end

  # Generates a tree representation of the object
  # @return [String] A string representation of the object's attribute tree
  def to_tree
    output = "#{self.class}\n"
    self.class.attributes.each_with_index do |(name, type), index|
      value = send(name)
      is_last = index == self.class.attributes.length - 1
      context = DiffContext.new(nil, nil, show_unchanged: false)
      formatted = context.format_value(value)
      output << context.tree_line(is_last, "#{name} (#{type}): #{formatted}")
    end
    output
  end
end
