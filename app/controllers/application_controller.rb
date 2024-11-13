class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)

    if decoded
      @current_entity = decoded[:entity_type].constantize.find(decoded[:entity_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_entity
    @current_entity
  end
end
