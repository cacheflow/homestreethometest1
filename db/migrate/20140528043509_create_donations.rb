class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.references :donor, index: true
      t.references :resident, index: true

      t.timestamps
    end
  end
end
