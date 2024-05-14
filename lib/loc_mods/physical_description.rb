# frozen_string_literal: true

require "shale"

require_relative "extent"
require_relative "form"
require_relative "physical_description_note"
require_relative "string_plus_language"

module LocMods
  class PhysicalDescription < Shale::Mapper
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :form, Form, collection: true
    attribute :reformatting_quality, Shale::Type::String, collection: true
    attribute :internet_media_type, Shale::Type::String, collection: true
    attribute :extent, Extent, collection: true
    attribute :digital_origin, Shale::Type::String, collection: true
    attribute :note, PhysicalDescriptionNote, collection: true

    xml do
      root "physicalDescription"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_element "form", to: :form
      map_element "reformattingQuality", to: :reformatting_quality
      map_element "internetMediaType", to: :internet_media_type
      map_element "extent", to: :extent
      map_element "digitalOrigin", to: :digital_origin
      map_element "note", to: :note
    end
  end
end
