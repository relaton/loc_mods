# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class Note < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::Value

    xml do
      root "note"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "ID", to: :id
    end
  end
end
