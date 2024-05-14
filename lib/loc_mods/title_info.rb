# frozen_string_literal: true

require "shale"
require_relative "non_sort"

module LocMods
  class TitleInfo < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :other_type, Shale::Type::Value
    attribute :supplied, Shale::Type::Value
    attribute :alt_rep_group, Shale::Type::String
    attribute :alt_format, Shale::Type::Value
    attribute :content_type, Shale::Type::String
    attribute :name_title_group, Shale::Type::String
    attribute :usage, Shale::Type::Value
    attribute :id, Shale::Type::Value
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :title, Shale::Type::String, collection: true
    attribute :sub_title, Shale::Type::String, collection: true
    attribute :part_number, Shale::Type::String, collection: true
    attribute :part_name, Shale::Type::String, collection: true
    attribute :non_sort, NonSort, collection: true

    xml do
      root "titleInfo"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "type", to: :type
      map_attribute "otherType", to: :other_type
      map_attribute "supplied", to: :supplied
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "altFormat", to: :alt_format
      map_attribute "contentType", to: :content_type
      map_attribute "nameTitleGroup", to: :name_title_group
      map_attribute "usage", to: :usage
      map_attribute "ID", to: :id
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label

      map_element "nonSort", to: :non_sort
      map_element "title", to: :title
      map_element "subTitle", to: :sub_title
      map_element "partNumber", to: :part_number
      map_element "partName", to: :part_name
    end
  end
end
