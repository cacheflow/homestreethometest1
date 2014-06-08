class PartnerReporting < ActiveRecord::Base
	has_many :residents, foreign_key: :partner_id
end
