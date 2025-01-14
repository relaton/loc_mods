# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "parses and serializes a simple file" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end

  # Only using limit of 5000 for performance reasons, there are 20006 entries
  # as of 2024-05-03

  SKIP_IDS = [
    "allrecords-MODS-991000197019708106"
  ].freeze

  # TODO: removing limits to test all records
  limit = 50_000
  Dir.glob("spec/fixtures/allrecords-MODS-*.xml").each do |f|
    limit -= 1
    break if limit == 0

    id = f.match(/(allrecords-MODS-\d+)/)[1]
    to_skip = SKIP_IDS.include?(id)

    it "round-trips NIST MODS record: #{id}", skip: to_skip do
      input = File.read(f)

      output = LocMods::Collection.from_xml(input).to_xml(
        pretty: true,
        declaration: true,
        encoding: "utf-8"
      )

      expect(output).to be_analogous_with(input)
    end
  end
end
