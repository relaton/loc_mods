# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class EnumerationAndChronology < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :unit_type, Shale::Type::String

    xml do
      root "enumerationAndChronology"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "unitType", to: :unit_type
    end
  end
end
