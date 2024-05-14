# frozen_string_literal: true

require "shale"

module LocMods
  class StringPlusLanguagePlusAuthority < Shale::Mapper
    attribute :content, Shale::Type::String
    attribute :authority, Shale::Type::String
    attribute :authority_uri, Shale::Type::Value
    attribute :value_uri, Shale::Type::Value
  end
end
