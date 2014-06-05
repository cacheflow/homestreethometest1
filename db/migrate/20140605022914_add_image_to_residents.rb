class AddImageToResidents < ActiveRecord::Migration
  def self.up
    add_attachment :residents, :image
  end

  def self.down
    remove_attachment :residents, :image
  end
end
