# frozen_string_literal: true

require "shale"

require_relative "date"
require_relative "detail"
require_relative "extent_definition"
require_relative "text"

module LocMods
  class Part < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :type, Shale::Type::String
    attribute :order, Shale::Type::Integer
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :detail, Detail, collection: true
    attribute :extent, ExtentDefinition, collection: true
    attribute :date, Date, collection: true
    attribute :text, Text, collection: true

    xml do
      root "part"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "ID", to: :id
      map_attribute "type", to: :type
      map_attribute "order", to: :order
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_element "detail", to: :detail
      map_element "extent", to: :extent
      map_element "date", to: :date
      map_element "text", to: :text
    end
  end
end
