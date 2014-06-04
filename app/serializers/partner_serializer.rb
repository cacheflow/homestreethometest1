class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :org, :address, :phone, :email, :website, :created_at, :name
  has_many :residents
end
