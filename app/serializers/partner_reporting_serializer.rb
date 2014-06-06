class PartnerReportingSerializer < ActiveModel::Serializer
  attributes :id, :name, :org, :email, :address, :sum, :avg, :max, :min, :count
  has_many :residents
end
