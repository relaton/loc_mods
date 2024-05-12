# frozen_string_literal: true

require "shale"

require_relative "string_plus_language"

module LocMods
  class StringPlusLanguagePlusAuthority < Shale::Mapper
    attribute :content, StringPlusLanguage
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
  end
end
