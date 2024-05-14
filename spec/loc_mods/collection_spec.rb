# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "does something useful" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end

  # Only using limit of 100 for performance reasons, there are 20006 entries
  # as of 2024-05-03
  limit = 100
  Dir.glob("spec/fixtures/allrecords-MODS-*.xml").each do |f|
    limit -= 1
    break if limit == 0

    it "round-trips NIST MODS record: #{f.match(/(allrecords-MODS-\d+)/)[1]}" do
      input = File.read(f)

      output = LocMods::Collection.from_xml(input).to_xml(
        pretty: true,
        declaration: true,
        encoding: "utf-8"
      )

      compare_c14n_xml(input, output)
    end
  end

  def compare_c14n_xml(input, output)
    g = Xml::C14n.format(input)
    r = Xml::C14n.format(output)
    expect(r).to eq(g)
  end
end
