# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Url < BaseMapper
    attribute :content, Shale::Type::Value
    attribute :date_last_accessed, Shale::Type::String
    attribute :display_label, Shale::Type::String
    attribute :note, Shale::Type::String
    attribute :access, Shale::Type::String
    attribute :usage, Shale::Type::String

    xml do
      root "url"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "dateLastAccessed", to: :date_last_accessed
      map_attribute "displayLabel", to: :display_label
      map_attribute "note", to: :note
      map_attribute "access", to: :access
      map_attribute "usage", to: :usage
    end
  end
end
