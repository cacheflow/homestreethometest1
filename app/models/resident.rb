class Resident < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  has_many :statuses
  has_many :donations
  has_many :donors, :through => :donations
  validates_format_of :name, with: /\A[a-zA-Z]{1,}\s[a-zA-Z]{1,}/
  validates_presence_of :name, :bio, :goals

  def total_donations
  	donations.sum(&:amount)
  end
end
