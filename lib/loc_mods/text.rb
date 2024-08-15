# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Text < BaseMapper
    attribute :content, :string
    attribute :display_label, :string
    attribute :type, :string

    xml do
      root "text"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
    end
  end
end
