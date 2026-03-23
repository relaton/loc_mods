# frozen_string_literal: true

module LocMods
  class Namespace < Lutaml::Xml::Namespace
    uri "http://www.loc.gov/mods/v3"
    prefix_default "mods"
    element_form_default :unqualified
    attribute_form_default :unqualified
  end
end
