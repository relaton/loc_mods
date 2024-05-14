# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "does something useful" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end
end
