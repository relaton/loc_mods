# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class TableOfContents < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :shareable, Shale::Type::Value
    attribute :alt_rep_group, Shale::Type::String
    attribute :alt_format, Shale::Type::Value
    attribute :content_type, Shale::Type::String

    xml do
      root "tableOfContents"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "shareable", to: :shareable
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "altFormat", to: :alt_format
      map_attribute "contentType", to: :content_type
    end
  end
end
