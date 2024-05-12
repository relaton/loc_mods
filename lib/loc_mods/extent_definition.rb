# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class ExtentDefinition < Shale::Mapper
    attribute :unit, Shale::Type::String
    attribute :start, StringPlusLanguage
    attribute :end, StringPlusLanguage
    attribute :total, Shale::Type::Integer
    attribute :list, StringPlusLanguage

    xml do
      root "extentDefinition"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_attribute "unit", to: :unit
      map_element "start", to: :start
      map_element "end", to: :end
      map_element "total", to: :total
      map_element "list", to: :list
    end
  end
end
