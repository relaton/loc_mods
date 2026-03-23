# frozen_string_literal: true

require "lutaml/model"

module LocMods
  class RecordIdentifier < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :source, :string

    xml do
      element "recordIdentifier"
      namespace Namespace

      map_content to: :content
      map_attribute "source", to: :source
    end
  end
end
