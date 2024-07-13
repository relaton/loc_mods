# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Identifier < BaseMapper
    attribute :content, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :type_uri, Shale::Type::Value
    attribute :invalid, Shale::Type::Value
    attribute :alt_rep_group, Shale::Type::String

    xml do
      root "nameIdentifier"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "typeURI", to: :type_uri
      map_attribute "invalid", to: :invalid
      map_attribute "altRepGroup", to: :alt_rep_group
    end
  end
end
