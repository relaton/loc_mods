# frozen_string_literal: true

require_relative "base_mapper"

module LocMods
  class StringPlusLanguagePlusSupplied < BaseMapper
    attribute :content, :string
    attribute :supplied, :string
  end
end
