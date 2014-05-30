class ChangeNameOfRoles < ActiveRecord::Migration
  def change
  	rename_column :roles, :type, :name
  end
end
