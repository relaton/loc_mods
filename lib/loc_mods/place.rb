# frozen_string_literal: true

require "shale"

require_relative "place_term"

module LocMods
  class Place < Shale::Mapper
    attribute :supplied, Shale::Type::Value
    attribute :place_term, PlaceTerm, collection: true

    xml do
      root "place"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_attribute "supplied", to: :supplied
      map_element "placeTerm", to: :place_term
    end
  end
end
