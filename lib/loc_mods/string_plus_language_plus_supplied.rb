# frozen_string_literal: true

require "shale"

module LocMods
  class StringPlusLanguagePlusSupplied < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :supplied, Shale::Type::Value
  end
end
