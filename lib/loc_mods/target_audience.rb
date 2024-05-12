# frozen_string_literal: true

require "shale"

require_relative "string_plus_language_plus_authority"

module LocMods
  class TargetAudience < Shale::Mapper
    attribute :content, StringPlusLanguagePlusAuthority
    attribute :display_label, Shale::Type::String
    attribute :alt_rep_group, Shale::Type::String

    xml do
      root "targetAudience"
      namespace "http://www.loc.gov/mods/v3", "xmlns"

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
    end
  end
end
