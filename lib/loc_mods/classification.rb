# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Classification < BaseMapper
    attribute :content, Shale::Type::String
    attribute :edition, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :usage, Shale::Type::Value
    attribute :generator, Shale::Type::String

    xml do
      root "classification"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "edition", to: :edition
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
      map_attribute "generator", to: :generator
    end
  end
end
