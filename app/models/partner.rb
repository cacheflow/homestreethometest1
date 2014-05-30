class Partner < ActiveRecord::Base
  has_many :residents
  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/
  validates_format_of :website, with: /\A(\w|[.])[^\W]\w{1,}\.[a-zA-Z]{2,}/
  validates_length_of :phone, :is => 10
end
