# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class StringPlusLanguagePlusAuthority < BaseMapper
    attribute :content, Shale::Type::String
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
  end
end
