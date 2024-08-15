# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Classification < BaseMapper
    attribute :content, :string
    attribute :edition, :string
    attribute :display_label, :string
    attribute :alt_rep_group, :string
    attribute :usage, :string
    attribute :generator, :string

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
