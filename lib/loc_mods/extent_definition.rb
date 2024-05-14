# frozen_string_literal: true

require "shale"

module LocMods
  class ExtentDefinition < Shale::Mapper
    attribute :unit, Shale::Type::String
    attribute :start, Shale::Type::String
    attribute :end, Shale::Type::String
    attribute :total, Shale::Type::Integer
    attribute :list, Shale::Type::String

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
