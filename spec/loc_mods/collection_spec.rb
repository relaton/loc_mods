# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "does something useful" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end

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

      # expect(input).to be_equivalent_to(output)
      compare_c14n_xml(input, output)
    end
  end

  require "tempfile"
  def xml_pretty_format(content)
    g = nil
    Tempfile.create("temp.xml") do |f|
      f.write(content)
      f.flush
      g = `xmlstarlet ed -L -O #{f.path}`
    end
    g
  end

  def compare_c14n_xml(input, output)
    g = xml_pretty_format(input)
    r = xml_pretty_format(output)
    expect(r).to eq(g)
  end
end
