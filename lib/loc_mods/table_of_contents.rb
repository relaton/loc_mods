# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class TableOfContents < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :display_label, :string
    attribute :type, :string
    attribute :shareable, :string
    attribute :alt_rep_group, :string
    attribute :alt_format, :string
    attribute :content_type, :string

    xml do
      root "tableOfContents"
      namespace "http://www.loc.gov/mods/v3", nil

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
      map_attribute "type", to: :type
      map_attribute "shareable", to: :shareable
      map_attribute "altRepGroup", to: :alt_rep_group
      map_attribute "altFormat", to: :alt_format
      map_attribute "contentType", to: :content_type
    end
  end
end
