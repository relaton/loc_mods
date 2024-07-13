# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class RecordContentSource < BaseMapper
    attribute :authority, Shale::Type::String
    attribute :content, Shale::Type::String

    xml do
      root "RecordContentSource"
      map_content to: :content

      map_attribute "authority", to: :authority
    end
  end
end
