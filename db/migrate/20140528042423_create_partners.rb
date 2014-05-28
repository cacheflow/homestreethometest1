class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :org
      t.string :address
      t.integer :phone
      t.string :email
      t.string :website
      t.references :resident, index: true

      t.timestamps
    end
  end
end
