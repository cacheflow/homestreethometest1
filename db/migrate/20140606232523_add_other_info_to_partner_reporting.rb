class AddOtherInfoToPartnerReporting < ActiveRecord::Migration
  def change
  	add_column :partner_reportings, :org, :string
  	add_column :partner_reportings, :email, :string
  	add_column :partner_reportings, :address, :string
  end
end
