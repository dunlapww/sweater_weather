class Api::V1::BusinessesController < ApplicationController
  def index
    require 'pry'; binding.pry
    params = JSON.parse(request.body.read, symbolize_names: true)
  end
end