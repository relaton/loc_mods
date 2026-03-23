# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class RoleTerm < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :type, :string

    xml do
      element "roleTerm"
      namespace Namespace

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
