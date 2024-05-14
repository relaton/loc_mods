# frozen_string_literal: true

require "shale"

module LocMods
  class RecordIdentifier < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :source, Shale::Type::String

    xml do
      root "recordIdentifier"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "source", to: :source
    end
  end
end
