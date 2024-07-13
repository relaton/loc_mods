# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class HierarchicalPart < BaseMapper
    attribute :content, Shale::Type::String
    attribute :level, Shale::Type::Value
    attribute :period, Shale::Type::Value
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value

    xml do
      root "territory"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "level", to: :level
      map_attribute "period", to: :period
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
    end
  end
end
