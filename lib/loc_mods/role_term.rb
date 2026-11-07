# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class RoleTerm < Lutaml::Model::Serializable
    include MarcCodeLookup

    attribute :content, :string
    attribute :authority_uri, :string
    attribute :value_uri, :string
    attribute :authority, :string
    attribute :type, :string

    xml do
      element "roleTerm"
      namespace Namespace

      map_content to: :content
      map_attribute "authorityURI", to: :authority_uri
      map_attribute "valueURI", to: :value_uri
      map_attribute "authority", to: :authority
      map_attribute "type", to: :type
    end
  end
end
