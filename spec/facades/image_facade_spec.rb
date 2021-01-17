require 'rails_helper'

describe ImageFacade, type: :facade do
  it 'when given valid data, it returns an instance of Image' do
    VCR.use_cassette 'image_facade_good' do
      params = {location: "San Francisco, CA"}
      image = ImageFacade.get_image(params)
      expect(image).to be_a Image
    end
  end
  it 'when given valid data, but cant find an image, it returns a default image' do
    VCR.use_cassette 'image_facade_no_image_found' do
      params = {location: "Denver, CO"}
      image = ImageFacade.get_image(params)
      expect(image).to be_a Image
    end
  end
  it 'when bad search data, it returns a default image' do
    VCR.use_cassette 'image_facade_bad_search' do
      params = {location: "!@"}
      image = ImageFacade.get_image(params)
      expect(image).to be_a Image
    end
  end
end