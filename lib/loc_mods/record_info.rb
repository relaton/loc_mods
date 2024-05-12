# frozen_string_literal: true

require "shale"

require_relative "date"
require_relative "language"
require_relative "record_info_note"
require_relative "record_identifier"
require_relative "string_plus_language"
require_relative "string_plus_language_plus_authority"

module LocMods
  class RecordInfo < Shale::Mapper
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :record_content_source, StringPlusLanguagePlusAuthority, collection: true
    attribute :record_creation_date, Date, collection: true
    attribute :record_change_date, Date, collection: true
    attribute :record_identifier, RecordIdentifier, collection: true
    attribute :language_of_cataloging, Language, collection: true
    attribute :record_origin, StringPlusLanguage, collection: true
    attribute :description_standard, StringPlusLanguagePlusAuthority, collection: true
    attribute :record_info_note, RecordInfoNote, collection: true

    xml do
      root "recordInfo"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_element "recordContentSource", to: :record_content_source
      map_element "recordCreationDate", to: :record_creation_date
      map_element "recordChangeDate", to: :record_change_date
      map_element "recordIdentifier", to: :record_identifier
      map_element "languageOfCataloging", to: :language_of_cataloging
      map_element "recordOrigin", to: :record_origin
      map_element "descriptionStandard", to: :description_standard
      map_element "recordInfoNote", to: :record_info_note
    end
  end
end
