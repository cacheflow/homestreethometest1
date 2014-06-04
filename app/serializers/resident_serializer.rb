class ResidentSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :goals, :goal_monetary, :amount_raised
  has_many :donations
  has_many :donors
  has_many :statuses
end
