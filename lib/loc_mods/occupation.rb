# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  # LocMods::StringPlusLanguagePlusAuthority
  class Occupation < BaseMapper
    attribute :content, :string
    attribute :authority, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string

    xml do
      root "occupation"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
    end
  end
end
