class ChangeNameOfStatusColumn < ActiveRecord::Migration
  def change
  	rename_column :statuses, :update, :content
  end
end
