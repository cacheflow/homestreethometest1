class Donor < ActiveRecord::Base
  has_many :donations
  has_many :residents, :through => :donations

  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/
end
