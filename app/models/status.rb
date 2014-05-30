class Status < ActiveRecord::Base
  belongs_to :resident
  validates_presence_of :content

  def edit_content 
  	content.gsub(/\b((?:fuck|shit))/, 'puppy')
  end
end
