require 'rails_helper'

RSpec.describe 'App management', type: :request do
  include_context 'json request'
  include_context 'product response matcher'

  let(:url) { '/api/v1/products' }

  context 'viewing all products' do
    let!(:product_one) { create(:product) }
    let!(:product_two) { create(:product) }

    subject(:perform_request) { get url }

    it 'returns a collection of product details' do
      perform_request
      expect(json_body).to include(
        products: a_collection_containing_exactly(
          product_response_matcher(product: product_one),
          product_response_matcher(product: product_two)
        )
      )
    end
  end

  context 'creating a product' do
    subject(:perform_request) { post url, params: params }

    describe 'if the ASIN exists' do
      let(:product) do
        build(:product, asin: 'B002QYW8LW',
                        title: 'Baby Banana Bendable Training Toothbrush (Infant)',
                        review_count: 354,
                        price: 9.99)
      end

      let(:params) { { asin: 'B002QYW8LW' } }

      it 'creates the product record' do
        VCR.use_cassette('product_page') do
          expect { perform_request }.to change { Product.count }.by(1)
        end
      end

      it 'returns the product details' do
        VCR.use_cassette('product_page_existing_asin') do
          perform_request

          expect(json_body).to include(
            product: product_response_matcher(product: Product.first),
            message: 'The product has been saved.'
          )
        end
      end
    end

    describe 'if there is no product for the passed ASIN' do
      let(:params) { { asin: 'SOME_FAKE_ASIN' } }

      it 'raises a ProductNotFoundError with the correct message' do
        VCR.use_cassette('product_page_non_existin_asin') do
          perform_request

          expect(json_body).to include(
            message: 'No product found for the supplied ASIN.'
          )
        end
      end
    end

    describe 'if no `asin` parameter was passed' do
      let(:params) { nil }

      it 'raises a AsinRequiredError with the correct message' do
        perform_request

        expect(json_body).to include(
          message: "The 'asin' parameter is required."
        )
      end
    end

    describe 'if the `asin` parameter is empty' do
      let(:params) { { asin: '' } }

      it 'raises a AsinRequiredError with the correct message' do
        perform_request

        expect(json_body).to include(
          message: "The 'asin' parameter is required."
        )
      end
    end
  end

  context 'viewing a product' do
    let(:product) { create(:product) }

    describe 'if the product exists' do
      subject(:perform_request) { get "#{url}/#{product.id}" }

      it 'returns the product details' do
        perform_request
        expect(json_body).to include(product: product_response_matcher(product: product))
      end
    end

    describe 'if the product does not exists' do
      subject(:perform_request) { get "#{url}/1337" }

      it 'returns the product details' do
        perform_request
        expect(json_body).to include(message: "Couldn't find Product")
      end
    end
  end

  context 'updating a product' do
    let!(:product) { create(:product, title: 'Some Title', asin: 'B002QYW8LW') }

    subject(:perform_request) { put "#{url}/#{product.id}" }

    it 'returns the product details' do
      VCR.use_cassette('product_page_existing_asin') do
        perform_request

        product.reload

        expect(json_body).to include(
          product: a_hash_including(
            title: 'Baby Banana Bendable Training Toothbrush (Infant)'
          ),
          message: 'The product has been updated.'
        )
      end
    end
  end

  context 'deleting a product' do
    let!(:product) { create(:product) }

    subject(:perform_request) { delete "#{url}/#{product.id}" }

    describe 'if the product exists' do
      it 'returns the product details and correct message' do
        perform_request
        expect(json_body).to include(
          product: product_response_matcher(product: product),
          message: 'The product has been deleted.'
        )
      end
    end

    describe 'if the product does not exists' do
      subject(:perform_request) { delete "#{url}/1337" }

      it 'returns the product details' do
        perform_request
        expect(json_body).to include(message: "Couldn't find Product")
      end
    end
  end
end
