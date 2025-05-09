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

    context "create refuelings and deduce user balance" do
      it "create refuelings" do
        refueling = service_result

        expect(Refueling.where(user: user, gasstation: gasstation).last).to eq refueling
      end

      it "deduce user balance " do
        user_balance_before = user.balance
        refueling = service_result
        user.reload

        expect(user.balance).to be < user_balance_before
        
      end
    end
  end
end