# frozen_string_literal: true

require "shale"

module LocMods
  class StringPlusLanguage < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String

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
