# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class StringPlusLanguagePlusSupplied < BaseMapper
    attribute :content, Shale::Type::String
    attribute :supplied, Shale::Type::Value
  end
end
