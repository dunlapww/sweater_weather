class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageFacade.get_image(params)
    
    render json: ImageSerializer.new(image).to_json
  end
end