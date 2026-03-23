# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class Detail < Lutaml::Model::Serializable
    attribute :type, :string
    attribute :level, :integer
    attribute :number, :string, collection: true
    attribute :caption, :string, collection: true
    attribute :title, :string, collection: true

    xml do
      element "detail"
      namespace Namespace

      map_attribute "type", to: :type
      map_attribute "level", to: :level
      map_element "number", to: :number
      map_element "caption", to: :caption
      map_element "title", to: :title
    end
  end
end
