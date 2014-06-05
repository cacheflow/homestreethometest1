class AddImageToPartners < ActiveRecord::Migration
  def self.up
    add_attachment :partners, :image
  end

  def self.down
    remove_attachment :partners, :image
  end
end
