# frozen_string_literal: true

require "shale"

class TestMapper < Shale::Mapper
  include LocMods::ComparableMapper

  attribute :value, Shale::Type::String
end

RSpec.describe LocMods::ComparableMapper do
  describe ".compare" do
    it "compares values" do
      self_value = TestMapper.new(value: "to be removed")
      other_value = TestMapper.new(value: nil)

      result = self_value.compare(other_value)
      expect(result).to include(:value)
    end

    it "compares nil object" do
      self_value = LocMods::ComparableNil.new
      other_value = TestMapper.new(value: "any value")

      result = self_value.compare(other_value)
      expect(result).to eq nil
    end

    it "compares nil value with nil object" do
      self_value = TestMapper.new(value: nil)
      other_value = LocMods::ComparableNil.new

      result = self_value.compare(other_value)
      expect(result).to eq nil
    end

    it "compares existing value with nil object" do
      self_value = TestMapper.new(value: "any value")
      other_value = LocMods::ComparableNil.new

      result = self_value.compare(other_value)
      expect(result).to include(:value)
    end
  end
end
