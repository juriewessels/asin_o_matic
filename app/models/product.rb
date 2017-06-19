# An Amazon product's details
class Product < ApplicationRecord

  validates :asin, :title, :review_count, :price, presence: true

end
