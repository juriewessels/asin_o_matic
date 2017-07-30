# /api/v1/products
class Api::V1::ProductsController < Api::V1::BaseController

  before_action :find_product, only: %i[show update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def create
    @asin = product_params[:asin]
    @product = Product.find_or_initialize_by(asin: @asin)
    @product.update_attributes!(product_data)
  end

  def update
    @asin = @product.asin
    @product.update!(product_data)
  end

  def destroy
    @product.destroy!
  end

  private

  # returns the `#data` attribute of an `AsinOMator::Product` instance
  # failure to retrieve product data is handled in the `Api::V1::BaseController`
  def product_data
    AsinOMator::Product.new(asin: @asin).data
  end

  def product_params
    params.permit(:asin)
  end

  def find_product
    @product = Product.find_by!(id: params[:id])
  end

end
