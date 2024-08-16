# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class LanguageTerm < BaseMapper
    attribute :content, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string
    attribute :authority, :string
    attribute :type, :string

    xml do
      root "languageTerm"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "authority", to: :authority
      map_attribute "type", to: :type
    end
  end
end
