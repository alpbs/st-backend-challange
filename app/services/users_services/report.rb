module UsersServices
  class Report
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def perform
      { balance: user.balance, refuelings: }
    end

    def refuelings
      @refuelings ||= user.refuelings
    end

  end
end