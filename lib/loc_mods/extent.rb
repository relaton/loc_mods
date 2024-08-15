# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Extent < BaseMapper
    attribute :content, :string
    attribute :unit, :string

    xml do
      root "extent"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "unit", to: :unit
    end
  end
end
