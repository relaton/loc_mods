# frozen_string_literal: true

require "shale"

module LocMods
  class NonSort < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :space, Shale::Type::String

    xml do
      root "nonSort"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "space", to: :space,
                             namespace: "http://www.w3.org/XML/1998/namespace", prefix: "xml"
    end
  end
end
