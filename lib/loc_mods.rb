# frozen_string_literal: true

require_relative "loc_mods/version"

module LocMods
  class Error < StandardError; end
  # Your code goes here...
end

require "shale"
require "shale/adapter/nokogiri"
Shale.xml_adapter = Shale::Adapter::Nokogiri

require_relative "loc_mods/collection"
