# frozen_string_literal: true

require "shale"

module LocMods
  class RecordContentSource < Shale::Mapper
    attribute :authority, Shale::Type::String
    attribute :content, Shale::Type::String

    xml do
      root "RecordContentSource"
      map_content to: :content

      map_attribute "authority", to: :authority
    end
  end
end
