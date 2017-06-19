# Base controller for the V1 API
class Api::V1::BaseController < ApplicationController

  before_action :ensure_json

  rescue_from ActiveRecord::RecordNotFound, GetPageForAsin::ProductNotFoundError do |exception|
    render json: { message: exception.message }, status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { message: exception.message }, status: 422
  end

  rescue_from GetPageForAsin::AsinRequiredError, GetPageForAsin::MechanizerError do |exception|
    render json: { message: exception.message }, status: 500
  end

  def ensure_json
    render plain: 'Request format must be json.', status: 406 unless request.format == :json
  end

end
