require 'rails_helper'

describe 'class methods' do
  it 'can return image data' do
    VCR.use_cassette 'unsplash good image data' do
      params = { location: 'Seattle, WA' }
      image = UnsplashService.get_image(params)
      require 'pry'; binding.pry
      expect(image).to be_a Hash
      expect(image).to have_key(:total)
      expect(image[:total]).to be_a Integer
      expect(image).to have_key(:totalHits)
      expect(image[:totalHits]).to be_a Integer
      expect(image).to have_key(:hits)
      expect(image[:hits]).to be_a Array
      expect(image[:hits].first).to be_a Hash
      expect(image[:hits].first).to have_key(:id)
      expect(image[:hits].first[:id]).to be_a Integer
      expect(image[:hits].first).to have_key(:tags)
      expect(image[:hits].first[:tags]).to be_a String
      expect(image[:hits].first).to have_key(:webformatURL)
      expect(image[:hits].first[:webformatURL]).to be_a String
    end
  end

  it 'can return a default image when no image is found' do
    image_data = { total: 0,
                   totalHits: 0,
                   hits: [] }
    image = ImageService.assign_image(image_data)
    expected = { total: 0,
                 totalHits: 1,
                 hits: [
                   {
                     id: nil,
                     tags: 'no city image found',
                     webformatURL: 'https://cdn.pixabay.com/photo/2020/06/16/19/28/sunset-5306985_960_720.jpg',
                     user: 'kolaoltion',
                     user_id: 16_160_874
                   }
                 ] }
    expect(image).to eq(expected)
  end
end
