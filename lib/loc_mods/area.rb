# frozen_string_literal: true

require "shale"

require_relative "hierarchical_part"

module LocMods
  class Area < Shale::Mapper
    attribute :content, HierarchicalPart
    attribute :area_type, Shale::Type::Value

    xml do
      root "area"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "areaType", to: :area_type
    end
  end
end
