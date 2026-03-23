# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class ItemIdentifier < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :type, :string

    xml do
      element "itemIdentifier"
      namespace Namespace

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
