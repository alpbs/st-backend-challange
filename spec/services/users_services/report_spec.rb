require "rails_helper"

describe UsersServices::Report do
  subject(:service_result) { described_class.new(user).perform }

  let(:user) { FactoryBot.create(:user) }

  before do
    10.times { FactoryBot.create(:refueling, user: user) }
  end

  describe "#perform" do
    context "user report balance and refuelings" do
      it "returns has balance and refuelings" do

        expect(service_result).to match(balance: kind_of(BigDecimal), refuelings: kind_of(ActiveRecord::Associations::CollectionProxy))
      end

      it "returns the correct number of refuelings" do
        expect(service_result[:refuelings].size).to eq 10
      end
    end
  end
end