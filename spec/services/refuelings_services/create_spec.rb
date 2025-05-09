require "rails_helper"

describe RefuelingsServices::Create do
  let(:user) { FactoryBot.create(:user) }
  let(:gasstation) { FactoryBot.create(:gasstation) }
  let(:params) { {user: user, gasstation: gasstation, quantity: 10} }

  after do
    database_cleaner = DatabaseCleaner::ActiveRecord::Truncation.new
    database_cleaner.clean
  end
  
  describe "#perform" do
    subject(:service_result) { described_class.new(params).perform }

    context "user with balance" do
      it "create refuelings" do
        refueling = service_result

        expect(Refueling.where(user: user, gasstation: gasstation).last).to eq refueling
      end

      it "deduce user balance" do
        user_balance_before = user.balance
        refueling = service_result
        user.reload

        expect(user.balance).to be < user_balance_before
        
      end
    end

    context "user without balance" do
      before do
        user.update(balance: 0)
      end

      it "does not create refuelings" do
        service_result

        expect(Refueling.where(user: user, gasstation: gasstation).count).to eq 0
      end

      it "returns error message" do
        service_result

        expect(service_result.errors[:base]).to include("User balance is not enough")
      end
    end
  end
end