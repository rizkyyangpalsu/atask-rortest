class SessionsController < ApplicationController

  skip_before_action :authenticate_request, only: [:create]

  def create
    entity = User.find_by(username: params[:username]) || Team.find_by(username: params[:username])

    if entity&.authenticate(params[:password])
      token = JsonWebToken.encode(entity_id: entity.id, entity_type: entity.class.name)
      render json: { token: token, message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    # No need for session destroy with JWT; clients simply discard the token
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
