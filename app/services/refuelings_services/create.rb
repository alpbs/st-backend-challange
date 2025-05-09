module RefuelingsServices
  class Create
    DISCOUNT = 5

    attr_reader :user, :gasstation, :quantity

    def initialize(params)
      @user = params[:user]
      @gasstation = params[:gasstation]
      @quantity = params[:quantity] || 0
    end

    def perform
      return refueling unless valid_parameters?
      
      Refueling.transaction do
        refueling.save!
        unless user.update!(balance: user.balance - final_price)
          refueling.errors.add(:base, "User balance update failed")
          raise ActiveRecord::Rollback
        end
        refueling
      end

    end

    private
    
    def validate_user_balance
      if user.balance < final_price
        refueling.errors.add(:base, "User balance is not enough")
        return false
      end

      true
    end

    def validate_quantity
      if quantity.present? && quantity <= 0
        refueling.errors.add(:base, "Quantity must be greater than 0")
        return false
      end
      true
    end

    def valid_parameters?
      validate_quantity && validate_user_balance && refueling.valid?
    end

    def total_price
      @total_price ||= quantity * gasstation.price_per_liter
    end

    def final_price
      @final_price ||= total_price - discount
    end

    def discount
      @discount ||= total_price * (DISCOUNT.to_f / 100)
    end

    def refueling
      @refueling ||= Refueling.new(
        user: user,
        gasstation: gasstation,
        quantity: quantity,
        price_per_liter: gasstation.price_per_liter,
        discount: discount)
    end
  end
end