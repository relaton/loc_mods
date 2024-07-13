# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Detail < BaseMapper
    attribute :type, Shale::Type::String
    attribute :level, Shale::Type::Integer
    attribute :number, Shale::Type::String, collection: true
    attribute :caption, Shale::Type::String, collection: true
    attribute :title, Shale::Type::String, collection: true

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
