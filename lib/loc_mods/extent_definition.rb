# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class ExtentDefinition < BaseMapper
    attribute :unit, :string
    attribute :start, :string
    attribute :end, :string
    attribute :total, :integer
    attribute :list, :string

    xml do
      root "extentDefinition"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "unit", to: :unit
      map_element "start", to: :start
      map_element "end", to: :end
      map_element "total", to: :total
      map_element "list", to: :list
    end
  end
end
