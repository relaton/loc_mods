# frozen_string_literal: true

module LocMods
  class XmlSpace < Lutaml::Model::Type::String
    xml do
      namespace Lutaml::Xml::W3c::XmlNamespace
    end
  end
end
