require "rails_helper"

describe GasstationsServices::Index do
  subject(:service_result) { described_class.new.perform }

  before do
    10.times { FactoryBot.create(:gasstation) }
  end

  describe "#perform" do
    context "list all available gas stations" do
      it "returns an array of gas stations" do
        expect(service_result).to include(instance_of(Gasstation))
      end
      it "returns the correct number of gas stations" do
        expect(service_result.size).to eq 10
      end
    end
  end
end