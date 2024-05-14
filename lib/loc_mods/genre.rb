# frozen_string_literal: true

require "shale"

require_relative "string_plus_language_plus_authority"

module LocMods
  class Genre < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :usage, Shale::Type::String
    attribute :authority, Shale::Type::String

    xml do
      root "genre"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
      map_attribute "authority", to: :authority
    end
  end
end
