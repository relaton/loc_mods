# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class GeographicCode < BaseMapper
    attribute :content, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string
    attribute :authority, :string

    xml do
      root "geographicCode"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "authority", to: :authority
    end
  end
end
