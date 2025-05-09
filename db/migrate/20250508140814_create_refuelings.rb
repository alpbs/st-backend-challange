class CreateRefuelings < ActiveRecord::Migration[8.0]
  def change
    create_table :refuelings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gasstation, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :price_per_liter
      t.decimal :discount

      t.timestamps
    end
  end
end
