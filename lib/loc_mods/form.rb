# frozen_string_literal: true

require "shale"

module LocMods
  class Form < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :authority, Shale::Type::String

    xml do
      root "form"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
      map_attribute "authority", to: :authority
    end
  end
end
