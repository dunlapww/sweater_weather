class Api::V1::BusinessesController < ApplicationController
  def index
    BusinessService.get_business(params)
  end
end