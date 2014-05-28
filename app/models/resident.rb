class Resident < ActiveRecord::Base
  belongs_to :partner
  has_many :statuses
  has_many :donors, :through => :donations
end
