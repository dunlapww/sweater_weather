require 'rails_helper'

describe UnsplashImage, type: :model do
  it 'has attributes when valid photo data given' do
    image_json = File.read('spec/fixtures/poro_data/unsplash_image.json')
    image_data = JSON.parse(image_json, symbolize_names: true)
    image = UnsplashImage.new(image_data)
    expect(image).to be_a UnsplashImage
    expect(image.id). to eq(nil)
    expect(image.curator). to eq("https://unsplash.com/")
    expect(image.artist_link). to eq(image_data[:user][:portfolio_url])
    expect(image.artist_name). to eq(image_data[:user][:name])
    expect(image.image_path). to eq(image_data[:urls][:small])
    expect(image.alt_description). to eq(image_data[:alt_description])
  end
  
end
