# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class RecordInfoNote < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :type_uri, Shale::Type::Value
    attribute :id, Shale::Type::Value
    attribute :alt_rep_group, Shale::Type::String

    xml do
      root "recordInfoNote"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "typeURI", to: :type_uri
      map_attribute "ID", to: :id
      map_attribute "altRepGroup", to: :alt_rep_group
    end
  end
end
