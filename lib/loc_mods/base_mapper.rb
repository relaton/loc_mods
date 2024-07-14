# lib/loc_mods/base_mapper.rb
require "shale"
require_relative "comparable_mapper"

module LocMods

  # Base class for all object definitions
  class BaseMapper < Shale::Mapper
    include ComparableMapper
  end

  # Nil class substitute for comparison
  class ComparableNil < BaseMapper
  end

  # Comparison of two values for ComparableMapper
  class Comparison
    attr_accessor :original, :updated

    def initialize(original:, updated:)
      @original = original
      @updated = updated
    end
  end
end
