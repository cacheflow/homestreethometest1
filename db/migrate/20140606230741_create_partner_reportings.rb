class CreatePartnerReportings < ActiveRecord::Migration
  def change
    create_table :partner_reportings do |t|
      t.string :name
      t.integer :sum
      t.float :avg
      t.integer :min
      t.integer :max
      t.integer :count

      t.timestamps
    end
  end
end
