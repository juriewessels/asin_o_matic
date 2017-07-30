RSpec.shared_context 'product response matcher' do
  # a custom matcher for product responses
  # :reek:FeatureEnvy
  def product_response_matcher(product:)
    a_hash_including(id: product.id,
                     asin: product.asin,
                     title: product.title,
                     review_count: product.review_count,
                     price: product.price)
  end
end
