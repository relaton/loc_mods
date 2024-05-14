# frozen_string_literal: true

require "shale"

require_relative "cartographic_extension"

module LocMods
  class Cartographics < Shale::Mapper
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
    attribute :scale, Shale::Type::String
    attribute :projection, Shale::Type::String
    attribute :coordinates, Shale::Type::String, collection: true
    attribute :cartographic_extension, CartographicExtension, collection: true

    xml do
      root "cartographics"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_element "scale", to: :scale
      map_element "projection", to: :projection
      map_element "coordinates", to: :coordinates
      map_element "cartographicExtension", to: :cartographic_extension
    end
  end
end
