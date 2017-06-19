# Data object that creates product data from a Mechanize::Page object
class ProductData

  include Virtus.model

  attribute :page, Mechanize::Page
  attribute :asin, String
  attribute :title, String, default: :parse_title
  attribute :review_count, Integer, default: :parse_review_count
  attribute :price, Float, default: :parse_price

  def model_attributes
    attributes.except(:page)
  end

  private

  def parse_title
    page.at('#productTitle').text.strip
  end

  def parse_review_count
    page.at('#acrCustomerReviewText').text.match(/\d+/)[0]
  end

  def parse_price
    page.at('#priceblock_ourprice').text.match(/(\d+[,.]\d+)/)[0]
  end

end
