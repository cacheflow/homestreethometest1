class Donor < ActiveRecord::Base
  has_many :donations
  has_many :residents, :through => :donations
   validates_numericality_of :phone, less_than_or_equal_to: 19999999999, greater_than_or_equal_to: 1000000
  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/
end
