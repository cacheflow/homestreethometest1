class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :partners
  has_one :donor
  accepts_nested_attributes_for :donor
  has_many :residents

  def donor
    super || build_donor
  end

end
