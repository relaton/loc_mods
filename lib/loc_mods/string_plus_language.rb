# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class StringPlusLanguage < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :lang, :string
    attribute :script, :string
    attribute :transliteration, :string

    xml do
      element "nonSort"
      namespace Namespace

      map_content to: :content
      map_attribute "lang", to: :lang
      map_attribute "script", to: :script
      map_attribute "transliteration", to: :transliteration
    end
  end
end
