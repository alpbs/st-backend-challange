module GasstationsServices
  class Index
    def perform
      gasstations
    end

    private

    def gasstations
      @gas_stations ||= Gasstation.all.select(:name, :address, :price_per_liter, :id)
    end
  end
end