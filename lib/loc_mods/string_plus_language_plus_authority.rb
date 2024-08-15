# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class StringPlusLanguagePlusAuthority < BaseMapper
    attribute :content, :string
    attribute :authority, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string
  end
end
