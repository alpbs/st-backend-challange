class Refueling < ApplicationRecord
  belongs_to :user
  belongs_to :gasstation

  validates :quantity, presence: true
  validates :price_per_liter, presence: true
  validates :discount, presence: true
end
