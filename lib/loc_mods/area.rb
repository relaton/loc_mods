# frozen_string_literal: true

require_relative "base_mapper"

require_relative "hierarchical_part"

module LocMods
  class Area < BaseMapper
    attribute :content, HierarchicalPart
    attribute :area_type, Shale::Type::Value

    xml do
      root "area"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "areaType", to: :area_type
    end
  end
end
