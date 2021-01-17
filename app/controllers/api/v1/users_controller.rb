class Api::V1::UsersController < ApplicationController
  def create
    user_data = JSON.parse(request.body.read, symbolize_names: true)
    @user = User.new(user_data)
    require 'pry'; binding.pry

  end
 
end