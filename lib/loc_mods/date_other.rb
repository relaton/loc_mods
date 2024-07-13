# frozen_string_literal: true

require_relative "base_mapper"

require_relative "date"

module LocMods
  class DateOther < BaseMapper
    attribute :content, Shale::Type::String
    attribute :type, Shale::Type::String

    xml do
      root "dateOther"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
