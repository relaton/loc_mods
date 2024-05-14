# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "does something useful" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end

  it "round-trips a MODS entry" do
    input = File.read("spec/fixtures/record_1.c14.xml")

    output = LocMods::Collection.from_xml(input).to_xml(
      pretty: true,
      declaration: true,
      encoding: "utf-8",
    )

    # expect(input).to be_equivalent_to(output)
    compare_c14n_xml(input, output)
  end

  require 'tempfile'
  def compare_c14n_xml(input, output)
    g = nil
    r = nil
    Tempfile.create('input.xml') do |f|
      f.write(input)
      f.flush
      puts "*" *20
      puts "f.path #{f.path}"
      g = `xmlstarlet c14n #{f.path}`
    end
    Tempfile.create('output.xml') do |f|
      f.write(output)
      f.flush
      r = `xmlstarlet c14n #{f.path}`
    end
    expect(r).to eq(g)
  end
end
