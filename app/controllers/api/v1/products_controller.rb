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
    @product.update_attributes!(product_data.model_attributes)
  end

  def update
    @asin = @product.asin
    @product.update!(product_data.model_attributes)
  end

  def destroy
    @product.destroy!
  end

  private

  def product_data
    page = GetPageForAsin.call(asin: @asin)
    ProductData.new(asin: @asin, page: page)
  end

  def product_params
    params.permit(:asin)
  end

  def find_product
    @product = Product.find_by!(id: params[:id])
  end

end
