# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class TypeOfResource < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :collection, :string
    attribute :manuscript, :string
    attribute :display_label, :string
    attribute :alt_rep_group, :string
    attribute :usage, :string

    xml do
      root "typeOfResource"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "collection", to: :collection
      map_attribute "manuscript", to: :manuscript
      map_attribute "displayLabel", to: :display_label
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "usage", to: :usage
    end
  end
end
