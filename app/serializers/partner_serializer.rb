class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :org, :address, :phone, :email, :website, :created_at, :name, :donations
  has_many :residents
end
