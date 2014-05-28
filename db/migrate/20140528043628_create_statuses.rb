class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :update
      t.references :resident, index: true

      t.timestamps
    end
  end
end
