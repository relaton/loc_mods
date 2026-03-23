# frozen_string_literal: true

require "lutaml/model"

require_relative "hierarchical_part"

module LocMods
  class CitySection < Lutaml::Model::Serializable
    attribute :content, HierarchicalPart
    attribute :city_section_type, :string

    xml do
      element "citySection"
      namespace Namespace

      map_content to: :content
      map_attribute "citySectionType", to: :city_section_type
    end
  end
end
