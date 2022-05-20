class Merchant < ApplicationRecord
  has_many :items

  def self.find_by_name(search)
  where("LOWER(name) LIKE ?", "%#{search.downcase}%").first

  end
end
