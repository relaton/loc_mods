# frozen_string_literal: true

require "lutaml/model"

require_relative "copy_information"

module LocMods
  class HoldingSimple < Lutaml::Model::Serializable
    attribute :copy_information, CopyInformation, collection: true

    xml do
      element "holdingSimple"
      namespace Namespace

      map_element "copyInformation", to: :copy_information
    end
  end
end
