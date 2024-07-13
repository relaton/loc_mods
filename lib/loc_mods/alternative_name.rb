# frozen_string_literal: true

require_relative "base_mapper"

require_relative "identifier"
require_relative "name_part"
require_relative "role"

module LocMods
  class AlternativeName < BaseMapper
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_type, Shale::Type::String
    attribute :name_part, NamePart, collection: true
    attribute :display_form, Shale::Type::String, collection: true
    attribute :affiliation, Shale::Type::String, collection: true
    attribute :role, Role, collection: true
    attribute :description, Shale::Type::String, collection: true
    attribute :name_identifier, Identifier, collection: true

    xml do
      root "alternativeName"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altType", to: :alt_type
      map_element "namePart", to: :name_part
      map_element "displayForm", to: :display_form
      map_element "affiliation", to: :affiliation
      map_element "role", to: :role
      map_element "description", to: :description
      map_element "nameIdentifier", to: :name_identifier
    end
  end
end
