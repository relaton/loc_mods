# frozen_string_literal: true

require "shale"

require_relative "record"

module LocMods
  class Collection < Shale::Mapper
    attribute :mods, Record, collection: true

    xml do
      root "modsCollection"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_element "mods", to: :mods
    end
  end
end
