class Api::V1::UsersController < ApplicationController
  def create
    user_data = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(user_data)

    if user.save
      user_w_key = User.find(user.id)
      render json: UserSerializer.new(user_w_key)
    else
      render json: {errors:[{detail: user.errors.full_messages.to_sentence}]}
    end
  end

end
