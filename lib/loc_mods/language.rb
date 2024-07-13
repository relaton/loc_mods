# frozen_string_literal: true

require_relative "base_mapper"

require_relative "language_term"
require_relative "script_term"

module LocMods
  class Language < BaseMapper
    attribute :object_part, Shale::Type::String
    attribute :lang, Shale::Type::String
    attribute :script, Shale::Type::String
    attribute :transliteration, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String
    attribute :usage, Shale::Type::Value
    attribute :language_term, LanguageTerm, collection: true
    attribute :script_term, ScriptTerm, collection: true

    xml do
      root "languageOfCataloging"
      namespace "http://www.loc.gov/mods/v3", nil

      map_attribute "objectPart", to: :object_part
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
      map_element "languageTerm", to: :language_term
      map_element "scriptTerm", to: :script_term
    end
  end
end
