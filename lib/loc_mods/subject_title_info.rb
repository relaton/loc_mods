# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class SubjectTitleInfo < BaseMapper
    attribute :id, Shale::Type::Value
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :title, Shale::Type::String, collection: true
    attribute :sub_title, Shale::Type::String, collection: true
    attribute :part_number, Shale::Type::String, collection: true
    attribute :part_name, Shale::Type::String, collection: true
    attribute :non_sort, Shale::Type::String, collection: true

    xml do
      root "subjectTitleInfo"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "ID", to: :id
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_element "title", to: :title
      map_element "subTitle", to: :sub_title
      map_element "partNumber", to: :part_number
      map_element "partName", to: :part_name
      map_element "nonSort", to: :non_sort
    end
  end
end
