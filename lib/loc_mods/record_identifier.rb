# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class RecordIdentifier < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :source, Shale::Type::String

    xml do
      root "recordIdentifier"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "source", to: :source
    end
  end
end
