# Base controller for the V1 API
class Api::V1::BaseController < ApplicationController

  before_action :ensure_json

  rescue_from ActiveRecord::RecordNotFound, AsinOMator::ProductNotFoundError do |exception|
    render json: { message: exception.message }, status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { message: exception.message }, status: 422
  end

  rescue_from AsinOMator::AsinRequiredError, AsinOMator::MechanizerError do |exception|
    render json: { message: exception.message }, status: 500
  end

  def ensure_json
    render plain: 'Request format must be json.', status: 406 unless request.format == :json
  end

end
