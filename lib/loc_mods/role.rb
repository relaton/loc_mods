# frozen_string_literal: true

require "lutaml/model"

require_relative "role_term"

module LocMods
  class Role < Lutaml::Model::Serializable
    attribute :role_term, RoleTerm, collection: true

    xml do
      element "role"
      namespace Namespace

      map_element "roleTerm", to: :role_term
    end
  end
end
