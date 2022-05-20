class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_all_by_name(search)
    where("LOWER(name) LIKE ?", "%#{search.downcase}%")
  end
end
