# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class Publisher < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :authority, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string

    xml do
      element "publisher"
      namespace Namespace

      map_content to: :content
      map_attribute "authority", to: :authority
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
    end
  end
end
