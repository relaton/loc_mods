# frozen_string_literal: true

require "shale"

module LocMods
  # LocMods::StringPlusLanguagePlusSupplied
  class Edition < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :supplied, Shale::Type::String

    xml do
      root "edition"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "supplied", to: :supplied
    end
  end
end
