# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class StringPlusLanguage < BaseMapper
    attribute :content, :string
    attribute :lang, :string
    attribute :script, :string
    attribute :transliteration, :string

    xml do
      root "nonSort"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
    end
  end
end
