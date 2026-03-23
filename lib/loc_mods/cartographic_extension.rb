# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class CartographicExtension < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :display_label, :string

    xml do
      element "cartographicExtension"
      namespace Namespace

      map_content to: :content
      map_attribute "displayLabel", to: :display_label
    end
  end
end
