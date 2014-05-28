class Donation < ActiveRecord::Base
  belongs_to :donor
  belongs_to :resident

  validates_numericality_of :amount, only_integer: true
end
