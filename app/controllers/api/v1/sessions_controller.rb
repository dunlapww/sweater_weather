class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticate(user_params[:password])
      user_w_key = User.find(user.id)
      session[:id] = user_w_key[:id]
      render json: UserSerializer.new(user_w_key)
    else
      render json: { errors: [{ detail: 'Invalid credentials' }] }, status: :unauthorized
    end
  end

  protected

  def user_params
    user_data = JSON.parse(request.body.read, symbolize_names: true)
  end
end
