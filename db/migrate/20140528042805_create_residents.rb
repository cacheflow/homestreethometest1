class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :name
      t.string :picture
      t.string :bio
      t.string :goals
      t.string :goal_monetary
      t.string :amount_raised
      t.references :partner, index: true
      t.references :statuses, index: true
      t.references :donors, index: true

      t.timestamps
    end
  end
end
