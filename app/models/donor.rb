class Donor < ActiveRecord::Base
  belongs_to :user
  has_many :donations
  has_many :residents, :through => :donations
  validates_length_of :phone, :is => 10, allow_nil: true, allow_blank: true
  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/, allow_nil: true, allow_blank: true
end
