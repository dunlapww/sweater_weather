class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)

    if user.save
      user_w_key = User.find(user.id)
      session[:id] = user_w_key[:id]
      render json: UserSerializer.new(user_w_key)
    else
      render json: {errors:[{detail: user.errors.full_messages.to_sentence}]}, status: :bad_request
    end
  end

  protected

  def user_params
    user_data = JSON.parse(request.body.read, symbolize_names: true)
  end

end
