# frozen_string_literal: true

require "lutaml/model"

require_relative "date"

module LocMods
  class DateOther < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :type, :string

    xml do
      element "dateOther"
      namespace Namespace

      map_content to: :content
      map_attribute "type", to: :type
    end
  end
end
