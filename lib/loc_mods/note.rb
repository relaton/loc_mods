# frozen_string_literal: true

require "shale"

module LocMods
  class Note < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :script, Shale::Type::String

    xml do
      root "note"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "ID", to: :id
      map_attribute "script", to: :script
    end
  end
end
