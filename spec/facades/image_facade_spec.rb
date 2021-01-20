require 'rails_helper'

describe ImageFacade, type: :facade do
  it 'when given valid data, it returns an instance of Image' do
    VCR.use_cassette 'image_facade_good' do
      params = {location: "San Francisco, CA"}
      image = ImageFacade.get_image(params)
      expect(image).to be_a UnsplashImage
    end
  end
end