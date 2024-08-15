# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class CartographicExtension < BaseMapper
    attribute :content, :string
    attribute :display_label, :string

    xml do
      root "cartographicExtension"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
    end
  end
end
