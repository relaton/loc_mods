# frozen_string_literal: true

require_relative "base_mapper"

require_relative "record"

module LocMods
  class Collection < BaseMapper
    attribute :mods, Record, collection: true
    attribute :schema_location, Shale::Type::String

    xml do
      root "modsCollection"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "schemaLocation", to: :schema_location,
                                      namespace: "http://www.w3.org/2001/XMLSchema-instance",
                                      prefix: "xsi"

      map_element "mods", to: :mods
    end
  end
end
