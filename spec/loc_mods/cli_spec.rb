# frozen_string_literal: true

require 'loc_mods/cli'

RSpec.describe LocMods::Cli do
  describe ".format_value" do
    it "uses the nil output" do
      result = subject.send(:format_value, nil, "test")

      expect(result).to eq "test"
    end
  end
end
