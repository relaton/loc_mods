# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class Form < BaseMapper
    attribute :content, :string
    attribute :type, :string
    attribute :authority, :string

    xml do
      root "form"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
      map_attribute "authority", to: :authority
    end
  end
end
