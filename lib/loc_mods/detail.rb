# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class Detail < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :level, Shale::Type::Integer
    attribute :number, StringPlusLanguage, collection: true
    attribute :caption, StringPlusLanguage, collection: true
    attribute :title, StringPlusLanguage, collection: true

    xml do
      root "detail"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_attribute "type", to: :type
      map_attribute "level", to: :level
      map_element "number", to: :number
      map_element "caption", to: :caption
      map_element "title", to: :title
    end
  end
end
