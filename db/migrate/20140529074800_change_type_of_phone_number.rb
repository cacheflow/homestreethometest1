class ChangeTypeOfPhoneNumber < ActiveRecord::Migration
  def change
  	change_column :partners, :phone, :bigint
  	change_column :donors, :phone, :bigint
  end
end
