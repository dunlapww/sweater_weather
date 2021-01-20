require 'rails_helper'

describe 'class methods' do
  it 'can return image data' do
    VCR.use_cassette 'unsplash good image data' do
      params = { location: 'Seattle, WA' }
      image = UnsplashService.get_image(params)
      expect(image).to be_a Hash
      expect(image).to have_key :user
      expect(image[:user]).to have_key :portfolio_url
      expect(image[:user]).to have_key :name
      expect(image).to have_key :alt_description
      expect(image).to have_key :urls
      expect(image[:urls]).to have_key :small
    end
  end
end
