class Partner < ActiveRecord::Base
  has_many :residents
  validates_format_of :email, with: /[a-zA-Z0-9]\@[a-zA-Z]{2,}\.[a-zA-Z]{2,}/
  validates_format_of :website, with: /\A(\w|[.])[^\W]\w{1,}\.[a-zA-Z]{2,}/
  validates_numericality_of :phone, less_than_or_equal: 19999999999, greater_than_or_equal: 1000000
end
