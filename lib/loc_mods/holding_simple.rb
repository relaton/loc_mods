# frozen_string_literal: true

require_relative "base_mapper"

require_relative "copy_information"

module LocMods
  class HoldingSimple < BaseMapper
    attribute :copy_information, CopyInformation, collection: true

    xml do
      root "holdingSimple"
      namespace "http://www.loc.gov/mods/v3", nil

      map_element "copyInformation", to: :copy_information
    end
  end
end
