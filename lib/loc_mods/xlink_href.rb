# frozen_string_literal: true

module LocMods
  class XlinkHref < Lutaml::Model::Type::String
    xml do
      namespace XlinkNamespace
    end
  end
end
