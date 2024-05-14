# frozen_string_literal: true

require "shale"

require_relative "cartographics"
require_relative "genre"
require_relative "geographic_code"
require_relative "hierarchical_geographic"
require_relative "string_plus_language_plus_authority"
require_relative "subject_name"
require_relative "subject_title_info"
require_relative "temporal"
require_relative "occupation"

module LocMods
  class Subject < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :usage, Shale::Type::Value
    attribute :topic, Shale::Type::String, collection: true
    attribute :geographic, Shale::Type::String, collection: true
    attribute :temporal, Temporal, collection: true
    attribute :title_info, SubjectTitleInfo, collection: true
    attribute :name, SubjectName, collection: true
    attribute :geographic_code, GeographicCode, collection: true
    attribute :hierarchical_geographic, HierarchicalGeographic, collection: true
    attribute :cartographics, Cartographics, collection: true
    attribute :occupation, Occupation, collection: true
    attribute :genre, Genre, collection: true

    xml do
      root "subject"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "ID", to: :id
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
      map_element "topic", to: :topic
      map_element "geographic", to: :geographic
      map_element "temporal", to: :temporal
      map_element "titleInfo", to: :title_info
      map_element "name", to: :name
      map_element "geographicCode", to: :geographic_code
      map_element "hierarchicalGeographic", to: :hierarchical_geographic
      map_element "cartographics", to: :cartographics
      map_element "occupation", to: :occupation
      map_element "genre", to: :genre
    end
  end
end
