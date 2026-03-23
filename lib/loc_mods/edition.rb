# frozen_string_literal: true

require "lutaml/model"

module LocMods
  # LocMods::StringPlusLanguagePlusSupplied
  class Edition < Lutaml::Model::Serializable
    attribute :content, :string
    attribute :supplied, :string

    xml do
      element "edition"
      namespace Namespace

      map_content to: :content
      map_attribute "supplied", to: :supplied
    end
  end
end
