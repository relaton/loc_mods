# frozen_string_literal: true

require "shale"

module LocMods
  class AccessCondition < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :alt_format, Shale::Type::Value
    attribute :content_type, Shale::Type::String

    xml do
      root "accessCondition"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "type", to: :type
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "altFormat", to: :alt_format
      map_attribute "contentType", to: :content_type
    end
  end
end
