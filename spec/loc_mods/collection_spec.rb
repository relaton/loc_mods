# frozen_string_literal: true

RSpec.describe LocMods::Collection do
  it "does something useful" do
    yaml = LocMods::Collection.from_xml(File.read("spec/fixtures/record_1.xml")).to_yaml
    expect(yaml).to_not be_nil
  end

  # Only using limit of 100 for performance reasons, there are 20006 entries
  # as of 2024-05-03

  # Skipping the following tests due to order swaps
  # Swap of "place" and "publisher" orders
  SWAPPED_PLACE_PUBLISHER = %w[
    allrecords-MODS-991000030219708106
    allrecords-MODS-991000030229708106
  ].freeze

  # Swap of "topic" and "genre" orders
  SWAPPED_TOPIC_GENRE = %w[
    allrecords-MODS-991000083229708106
    allrecords-MODS-991000085919708106
  ].freeze

  # Swap of "geographic" and "topic" orders
  SWAPPED_GEOGRAPHIC_TOPIC = %w[
    allrecords-MODS-991000030349708106
    allrecords-MODS-991000033559708106
    allrecords-MODS-991000064369708106
    allrecords-MODS-991000080319708106
    allrecords-MODS-991000080799708106
    allrecords-MODS-991000081439708106
    allrecords-MODS-991000083229708106
    allrecords-MODS-991000083259708106
    allrecords-MODS-991000084859708106
    allrecords-MODS-991000085149708106
    allrecords-MODS-991000085239708106
    allrecords-MODS-991000085749708106
    allrecords-MODS-991000085919708106
    allrecords-MODS-991000086099708106
    allrecords-MODS-991000086889708106
    allrecords-MODS-991000086969708106
    allrecords-MODS-991000087889708106
    allrecords-MODS-991000088849708106
    allrecords-MODS-991000088859708106
    allrecords-MODS-991000088869708106
    allrecords-MODS-991000089819708106
    allrecords-MODS-991000090749708106
    allrecords-MODS-991000090819708106
    allrecords-MODS-991000090969708106
    allrecords-MODS-991000090979708106
    allrecords-MODS-991000091029708106
    allrecords-MODS-991000091039708106
    allrecords-MODS-991000091419708106
    allrecords-MODS-991000091449708106
    allrecords-MODS-991000091599708106
    allrecords-MODS-991000091609708106
    allrecords-MODS-991000091619708106
    allrecords-MODS-991000091639708106
    allrecords-MODS-991000091709708106
    allrecords-MODS-991000091729708106
  ].freeze

  SKIP_IDS = SWAPPED_GEOGRAPHIC_TOPIC + SWAPPED_PLACE_PUBLISHER + SWAPPED_TOPIC_GENRE

  limit = 5000
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
