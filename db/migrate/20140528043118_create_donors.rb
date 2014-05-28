class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :name
      t.string :org
      t.string :email
      t.integer :phone
      t.boolean :email_updates
      t.boolean :phone_updates
      t.references :donations, index: true
      t.references :resident, index: true

      t.timestamps
    end
  end
end
