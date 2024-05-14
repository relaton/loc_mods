# frozen_string_literal: true

require "shale"

require_relative "string_plus_language_plus_authority"

module LocMods
  class TypeOfResource < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :collection, Shale::Type::Value
    attribute :manuscript, Shale::Type::Value
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :usage, Shale::Type::Value

    xml do
      root "typeOfResource"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "collection", to: :collection
      map_attribute "manuscript", to: :manuscript
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
    end
  end
end
