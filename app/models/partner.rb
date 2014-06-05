class Partner < ActiveRecord::Base
  belongs_to :user
  has_many :residents
  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/
  validates_format_of :website, with: /\A(\w|[.])[^\W]\w{1,}\.[a-zA-Z]{2,}/
  validates_length_of :phone, :is => 10

  has_attached_file :image, 
            :style => { 
            :medium => "300x300>", :thumb => "100x100>" },
            :storage => :s3
            

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
