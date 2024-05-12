# frozen_string_literal: true

require "shale"

require_relative "date"

module LocMods
  class DateOther < Shale::Mapper
    attribute :content, Date
    attribute :type, Shale::Type::String

    xml do
      root "dateOther"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
