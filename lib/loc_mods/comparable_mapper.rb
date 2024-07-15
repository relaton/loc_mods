# frozen_string_literal: true

# lib/loc_mods/comparable_mapper.rb

module LocMods
  # Enable comparison of two class models solely based on attribute values in
  # a recursive manner.
  module ComparableMapper
    # TODO: Implement Comparable
    # include Comparable
    # def <=>(other)
    #   attributes.foo <=> other.attributes.foo
    # end
    # def inspect
    #   @foo
    # end

    def eql?(other)
      other.class == self.class &&
        self.class.attributes.all? do |attr|
          send(attr) == other.send(attr)
        end
    end

    alias == eql?

    def hash
      ([self.class] + self.class.attributes.map(&:hash)).hash
    end

    def compare(other)
      differences = {}

      # puts "Debugging: Attributes for #{self.class.name}"
      # pp self.class.attributes.keys

      self.class.attributes.each_key do |attr|
        self_value = respond_to?(attr) ? send(attr) : nil
        other_value = other.respond_to?(attr) ? other.send(attr) : nil

        # puts "Debugging: Comparing attribute '#{attr}'"
        # puts "  Self value: #{self_value.inspect}"
        # puts "  Other value: #{other_value.inspect}"

        compared = compare_values(self_value, other_value)
        if compared
          # puts "DETECTED DIFFERENCE! #{compared.inspect}"
          differences[attr] = compared
        end
      end

      # unless differences.empty?
      #   puts "DIFFERENCES ARE"
      #   pp differences
      # end

      differences.empty? ? nil : differences
    end

    private

    def compare_values(self_value, other_value)
      # puts "compare_values (self_value: #{self_value}, other_value: #{other_value})"
      case self_value
      when Array
        # puts "compare_values case 1"
        compare_arrays(self_value, other_value || [])
      when NilClass, ComparableNil
        unless [NilClass, ComparableNil].include?(other_value.class)
          Comparison.new(original: self_value, updated: other_value.to_xml)
        end
      when ComparableMapper
        # puts "compare_values case 2"
        self_value.compare(other_value)
      else
        if self_value != other_value
          # puts "compare_values case 3"
          Comparison.new(original: self_value, updated: other_value)
        end
      end
    end

    def compare_arrays(self_array, other_array)
      differences = {}
      max_length = [self_array.size, other_array.size].max

      max_length.times do |index|
        self_item = self_array[index] || ComparableNil.new
        other_item = other_array[index] || ComparableNil.new

        compared = compare_values(self_item, other_item)
        differences[index] = compared if compared

        # if index >= self_array.size
        #   puts "case 1 #{compared}"
        #   # differences[index] = compared
        # elsif index >= other_array.size
        #   puts "case 2.1 #{self_item}"
        #   puts "case 2.2 #{compared}"
        #   # differences[index] = compared
        # end
      end

      if self_array.size != other_array.size
        differences[:_array_size_difference] = Comparison.new(
          original: self_array.size,
          updated: other_array.size
        )
      end

      differences.empty? ? nil : differences
    end
  end
end
