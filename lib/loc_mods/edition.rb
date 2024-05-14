# frozen_string_literal: true

require "shale"

require_relative "string_plus_language_plus_supplied"

module LocMods
  class Edition < LocMods::StringPlusLanguagePlusSupplied
    attribute :content, Shale::Type::String
    attribute :supplied, Shale::Type::Value

    xml do
      root "edition"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "supplied", to: :supplied
    end
  end
end
