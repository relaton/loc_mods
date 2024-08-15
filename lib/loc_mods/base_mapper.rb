# frozen_string_literal: true

require "lutaml/model"
require_relative "comparable_mapper"

module LocMods
  # Base class for all object definitions
  class BaseMapper < Lutaml::Model::Serializable
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
