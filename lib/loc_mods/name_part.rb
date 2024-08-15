# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class NamePart < BaseMapper
    attribute :content, :string
    attribute :type, :string

    xml do
      root "namePart"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
