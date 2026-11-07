# frozen_string_literal: true

# Load only the code lists: the full loc_marc also loads shale and sets
# the global Shale XML adapter.
require "loc_marc/codes"

module LocMods
  # Looks up a coded term in the MARC 21 code lists from the loc_marc gem.
  #
  # The `authority` attribute selects the code list. Only the authorities in
  # CODE_LISTS are supported. A term with `type="text"`, an unknown authority
  # or an unknown code gives `nil`.
  module MarcCodeLookup
    CODE_LISTS = {
      "marcrelator" => ::LocMarc::Codes::Relator,
      "marccountry" => ::LocMarc::Codes::Country,
      "marcgac" => ::LocMarc::Codes::GeographicArea,
      "iso639-2b" => ::LocMarc::Codes::Language,
    }.freeze

    # @return [Hash{Symbol=>Object}, nil] a frozen copy of
    #   `{ code:, description:, deprecated: }`
    def code_info
      list = marc_code_list
      return unless list && content

      entry = lookup_marc_code(list, content.strip.downcase)
      entry&.transform_values { |v| v.dup.freeze }&.freeze
    end

    # @return [String, nil] the description of the code
    def code_description
      code_info&.fetch(:description)
    end

    private

    def marc_code_list
      return if respond_to?(:type) && type == "text"
      return unless authority

      CODE_LISTS[authority.strip.downcase]
    end

    # MARC geographic area codes are padded with hyphens to 7 characters
    # ("n-us---"); the code list stores them without the padding ("n-us").
    def lookup_marc_code(list, code)
      entry = list.lookup(code)
      return entry if entry || list != ::LocMarc::Codes::GeographicArea

      list.lookup(code.sub(/-+\z/, ""))
    end
  end
end
