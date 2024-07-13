# lib/loc_mods/comparable_mapper.rb

module LocMods
  module ComparableMapper
    # def self.included(base)
    #   base.extend(ClassMethods)
    # end

    # module ClassMethods
    #   def attribute_mapping
    #     @attribute_mapping ||= attributes.to_h do |name, attribute|
    #       [name, attribute.type]
    #     end
    #   end
    # end

    def compare(other)
      return {} unless other.is_a?(self.class)

      differences = {}

      # puts "Debugging: Attributes for #{self.class.name}"
      # pp self.class.attributes.keys

      self.class.attributes.each_key do |attr|
        self_value = self.send(attr)
        other_value = other.send(attr)

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
        compare_arrays(self_value, other_value)
      when Shale::Mapper
        # puts "compare_values case 2"
        self_value.compare(other_value)
      else
        if self_value != other_value
          # puts "compare_values case 3"
          { self: self_value, other: other_value }
        end
      end
    end

    def compare_arrays(self_array, other_array)
      differences = {}
      max_length = [self_array.size, other_array.size].max

      max_length.times do |index|
        self_item = self_array[index]
        other_item = other_array[index]

        if index >= self_array.size
          compared = compare_values(other_item, nil)
          differences[index] = { self: compared[:other], other: compared[:self] }
        elsif index >= other_array.size
          differences[index] = compare_values(self_item, nil)
        else
          compared = compare_values(self_item, other_item)
          differences[index] = compared if compared
        end
      end

      if self_array.size != other_array.size
        differences[:array_size_difference] = {
          self: self_array.size,
          other: other_array.size,
        }
      end

      differences.empty? ? nil : differences
    end
  end
end
