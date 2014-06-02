class Fulfillment < ActiveRecord::Base
  def password
    password_hash ? @password ||= BCrypt::Password.new(password_hash) : nil
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, test_password)
    fulfillment = Fulfillment.find_by_email(email)
    if fulfillment && fulfillment.password == test_password
      fulfillment
    else
      nil
    end
  end

end
