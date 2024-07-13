# frozen_string_literal: true

require_relative "base_mapper"

require_relative "role_term"

module LocMods
  class Role < BaseMapper
    attribute :role_term, RoleTerm, collection: true

    xml do
      root "role"
      namespace "http://www.loc.gov/mods/v3", nil

      map_element "roleTerm", to: :role_term
    end
  end
end
