# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class NonSort < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :space, ::Lutaml::Xml::W3c::XmlSpaceType

    xml do
      element "nonSort"
      namespace Namespace

      map_content to: :content
      map_attribute "space", to: :space
    end
  end
end
