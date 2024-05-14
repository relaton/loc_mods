# frozen_string_literal: true

require "shale"

module LocMods
  class PhysicalLocation < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String

    xml do
      root "physicalLocation"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
    end
  end
end
