# frozen_string_literal: true

require_relative "base_mapper"

require_relative "place_term"

module LocMods
  class Place < BaseMapper
    attribute :supplied, :string
    attribute :place_term, PlaceTerm, collection: true

    xml do
      root "place"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "supplied", to: :supplied
      map_element "placeTerm", to: :place_term
    end
  end
end
