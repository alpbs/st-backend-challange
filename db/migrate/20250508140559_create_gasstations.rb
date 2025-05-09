class CreateGasstations < ActiveRecord::Migration[8.0]
  def change
    create_table :gasstations do |t|
      t.string :name
      t.string :address
      t.decimal :price_per_liter

      t.timestamps
    end
  end
end
