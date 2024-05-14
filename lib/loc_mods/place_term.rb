# frozen_string_literal: true

require "shale"

module LocMods
  class PlaceTerm < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
    attribute :authority, Shale::Type::String
    attribute :type, Shale::Type::String

    xml do
      root "placeTerm"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "authority", to: :authority
      map_attribute "type", to: :type
    end
  end
end
