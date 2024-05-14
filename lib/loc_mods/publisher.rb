# frozen_string_literal: true

require "shale"

require_relative "string_plus_language_plus_supplied"

module LocMods
  class Publisher < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value

    xml do
      root "publisher"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
    end
  end
end
