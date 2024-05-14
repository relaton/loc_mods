# frozen_string_literal: true

require "shale"

require_relative "cartographic_extension"
require_relative "holding_simple"
require_relative "physical_location"
require_relative "url"

module LocMods
  class Location < Shale::Mapper
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :physical_location, PhysicalLocation, collection: true
    attribute :shelf_locator, Shale::Type::String, collection: true
    attribute :url, Url, collection: true
    attribute :holding_simple, HoldingSimple
    attribute :holding_external, CartographicExtension

    xml do
      root "location"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_element "physicalLocation", to: :physical_location
      map_element "shelfLocator", to: :shelf_locator
      map_element "url", to: :url
      map_element "holdingSimple", to: :holding_simple
      map_element "holdingExternal", to: :holding_external
    end
  end
end
