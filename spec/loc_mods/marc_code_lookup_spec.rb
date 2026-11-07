# frozen_string_literal: true

RSpec.describe LocMods::MarcCodeLookup do
  # Builds a MODS element and parses it with the class under test.
  def parse_term(klass, code, **attrs)
    element = klass.mappings_for(:xml).root_element
    attr_str = attrs.map { |k, v| %( #{k}="#{v}") }.join
    klass.from_xml(
      %(<#{element} xmlns="http://www.loc.gov/mods/v3"#{attr_str}>) +
        %(#{code}</#{element}>),
    )
  end

  describe LocMods::RoleTerm do
    let(:relators) { "http://id.loc.gov/vocabulary/relators" }
    let(:term) do
      parse_term(described_class, "aut",
                 type: "code", authority: "marcrelator",
                 authorityURI: relators, valueURI: "#{relators}/aut")
    end

    it "parses the authority attributes" do
      expect([term.authority, term.authority_uri, term.value_uri])
        .to eq ["marcrelator", relators, "#{relators}/aut"]
    end

    it "keeps the authority attributes on round-trip" do
      expect(term.to_xml).to include(
        'authority="marcrelator"',
        %(authorityURI="#{relators}"),
        %(valueURI="#{relators}/aut"),
      )
    end

    it "looks up a relator code" do
      expect(term.code_info)
        .to eq(code: "aut", description: "Author", deprecated: false)
    end

    it "gives the description of a relator code" do
      expect(term.code_description).to eq "Author"
    end

    it "returns a frozen copy of the code list entry" do
      expect(term.code_info.values_at(:description).push(term.code_info))
        .to all(be_frozen)
    end

    it "does not serialize the lookup result" do
      expect(term.to_xml).not_to include("Author")
    end

    it "returns nil for a text term" do
      text = parse_term(described_class, "Author",
                        type: "text", authority: "marcrelator")
      expect(text.code_info).to be_nil
    end
  end

  describe LocMods::PlaceTerm do
    def lookup(code, authority: "marccountry", **attrs)
      parse_term(described_class, code, authority: authority, **attrs)
        .code_info
    end

    it "looks up a deprecated country code" do
      expect(lookup("us", type: "code"))
        .to eq(code: "us", description: "United States", deprecated: true)
    end

    it "looks up a term without a type attribute" do
      expect(lookup("xxu")).to include(description: "United States")
    end

    it "ignores case and whitespace" do
      expect(lookup(" XXU ", authority: "MARCCountry"))
        .to include(code: "xxu")
    end

    it "looks up a geographic area code" do
      expect(lookup("a-cc-hk", authority: "marcgac"))
        .to include(description: "Hong Kong (China)")
    end

    it "does not remove hyphen padding outside marcgac" do
      expect(lookup("xxu--")).to be_nil
    end

    it "returns nil for an unknown code" do
      expect(lookup("zzzz")).to be_nil
    end

    it "returns nil for an authority without a MARC list" do
      expect(lookup("US", authority: "iso3166")).to be_nil
    end
  end

  describe LocMods::LanguageTerm do
    def lookup(code)
      parse_term(described_class, code, type: "code", authority: "iso639-2b")
        .code_description
    end

    it "looks up a language code" do
      expect(lookup("eng")).to eq "English"
    end

    it "does not look up a code from another list" do
      expect(lookup("en")).to be_nil
    end
  end

  describe LocMods::GeographicCode do
    def lookup(code, **attrs)
      parse_term(described_class, code, **attrs).code_info
    end

    it "looks up a code with hyphen padding" do
      expect(lookup("n-us---", authority: "marcgac"))
        .to eq(code: "n-us", description: "United States", deprecated: false)
    end

    it "looks up a one-letter code with hyphen padding" do
      expect(lookup("n------", authority: "marcgac"))
        .to include(description: "North America")
    end

    it "returns nil without an authority" do
      expect(lookup("a-cc-hk")).to be_nil
    end
  end
end
