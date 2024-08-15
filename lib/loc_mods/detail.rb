# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Detail < BaseMapper
    attribute :type, :string
    attribute :level, :integer
    attribute :number, :string, collection: true
    attribute :caption, :string, collection: true
    attribute :title, :string, collection: true

    xml do
      root "detail"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "type", to: :type
      map_attribute "level", to: :level
      map_element "number", to: :number
      map_element "caption", to: :caption
      map_element "title", to: :title
    end
  end
end
