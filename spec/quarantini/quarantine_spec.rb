# frozen_string_literal: true

require "quarantini/quarantine"

RSpec.describe Quarantini::Quarantine do
  subject(:quarantine) { described_class.new }

  describe ".expires_at" do
    context "with an unknown type" do
      specify do
        expect {
          described_class.new(expires_at: 3).expires_at
        }.to raise_error(ArgumentError, "Unknown expiry type Integer.  Expecting one of (nil|String|Date)")
      end
    end

    context "with nil" do
      specify do
        expect(described_class.new(expires_at: nil).expires_at).to eq(Date.today.next)
      end
    end

    context "with a valide date string of 01-01-2022" do
      specify do
        expect(described_class.new(expires_at: "01-01-2022").expires_at).to eq(Date.parse("01-01-2022"))
      end
    end

    context "with an invalid date string of 13-45-2022" do
      specify { expect { described_class.new(expires_at: "13-45-2022").expires_at }.to raise_error(Date::Error, "invalid date") }
    end

    context "with a Date of 01-01-2022" do
      specify do
        expected_date = Date.parse("01-01-2022")
        expect(described_class.new(expires_at: expected_date).expires_at).to eq(expected_date)
      end
    end
  end
end
