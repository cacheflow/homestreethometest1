class ResidentSerializer < ActiveModel::Serializer

  attributes :id, :name, :bio, :goals, :goal_monetary, :amount_raised, :image, :partnername, :partnerorg

  has_many :donations
  has_many :donors
  has_many :statuses
  def partnername
  	object.partner.name
  end
  def partnerorg
  	object.partner.org
  end

end
