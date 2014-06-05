class Resident < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  has_many :statuses
  has_many :donations
  has_many :donors, :through => :donations
  validates_format_of :name, with: /\A[a-zA-Z]{1,}\s[a-zA-Z]{1,}/
  validates_presence_of :name, :bio, :goals

  has_attached_file :image, 
            :style => { 
            :medium => "300x300>", :thumb => "100x100>" },
            :storage => :s3
            

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  def total_donations
  	return donations.sum(&:amount)
  end
end
