# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class TargetAudience < BaseMapper
    attribute :content, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String

    xml do
      root "targetAudience"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
    end
  end
end
