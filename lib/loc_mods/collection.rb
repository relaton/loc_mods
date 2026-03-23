# frozen_string_literal: true

require "lutaml/model"

require_relative "record"

module LocMods
  class Collection < Lutaml::Model::Serializable
    attribute :mods, Record, collection: true

    xml do
      element "modsCollection"
      namespace Namespace

      map_element "mods", to: :mods
    end
  end
end
