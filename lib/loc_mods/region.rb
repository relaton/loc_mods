# frozen_string_literal: true

require_relative "base_mapper"

require_relative "hierarchical_part"

module LocMods
  class Region < BaseMapper
    attribute :content, HierarchicalPart
    attribute :region_type, Shale::Type::Value

    xml do
      root "region"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "regionType", to: :region_type
    end
  end
end
