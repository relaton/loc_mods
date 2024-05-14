# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class StringPlusLanguagePlusSupplied < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :supplied, Shale::Type::Value
  end
end
