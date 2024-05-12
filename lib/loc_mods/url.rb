# frozen_string_literal: true

require "shale"

module LocMods
  class Url < Shale::Mapper
    attribute :content, Shale::Type::Value
    attribute :date_last_accessed, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :note, Shale::Type::String
    attribute :access, Shale::Type::String
    attribute :usage, Shale::Type::String

    xml do
      root "url"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "dateLastAccessed", to: :date_last_accessed
      map_attribute "displayLabel", to: :display_label
      map_attribute "note", to: :note
      map_attribute "access", to: :access
      map_attribute "usage", to: :usage
    end
  end
end
