# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class ItemIdentifier < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :type, Shale::Type::String

    xml do
      root "itemIdentifier"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
