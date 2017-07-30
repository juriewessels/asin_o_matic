# Base controller for the V1 API
class Api::V1::BaseController < ApplicationController

  # ensure the request format is JSON, else respond with a `406` status code
  before_action :ensure_json

  # handle non-existing records or Amazon product pages
  rescue_from ActiveRecord::RecordNotFound, AsinOMator::ProductNotFoundError do |exception|
    render json: { message: exception.message }, status: 404
  end

  # handle invalid records
  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { message: exception.message }, status: 422
  end

  # handle empty ASIN passed to AsinOMator and general Mechanize failures
  rescue_from AsinOMator::AsinRequiredError, AsinOMator::MechanizerError do |exception|
    render json: { message: exception.message }, status: 500
  end

  def ensure_json
    render plain: 'Request format must be json.', status: 406 unless request.format == :json
  end

end
