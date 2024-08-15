# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class EnumerationAndChronology < BaseMapper
    attribute :content, :string
    attribute :unit_type, :string

    xml do
      root "enumerationAndChronology"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "unitType", to: :unit_type
    end
  end
end
