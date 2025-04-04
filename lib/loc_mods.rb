# frozen_string_literal: true

require "lutaml/model"

Lutaml::Model::Config.configure do |config|
  config.xml_adapter_type = :nokogiri
end

module LocMods
  class Error < StandardError; end
end

require_relative "loc_mods/version"
require_relative "loc_mods/collection"
