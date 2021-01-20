require 'rails_helper'

describe Image, type: :model do
  it 'has attributes when valid photo data given' do
    image_data = { id: 3_864_320,
                   pageURL: 'https://pixabay.com/photos/alameda-ca-skyline-air-pollution-3864320/',
                   type: 'photo',
                   tags: 'alameda, ca, skyline',
                   previewURL: 'https://cdn.pixabay.com/photo/2018/12/09/03/48/alameda-3864320_150.jpg',
                   previewWidth: 150,
                   previewHeight: 112,
                   webformatURL: 'https://pixabay.com/get/55e8d3474950ac14f1dc846096293e77143ad7e05b4c704f742f72d4964dcd5a_640.jpg',
                   webformatWidth: 640,
                   webformatHeight: 480,
                   largeImageURL: 'https://pixabay.com/get/55e8d3474950ac14f6da8c7dda7936771c3edbec56596c48732e7bdd974cc550ba_1280.jpg',
                   imageWidth: 4608,
                   imageHeight: 3456,
                   imageSize: 3_567_553,
                   views: 1564,
                   downloads: 1216,
                   favorites: 1,
                   likes: 1,
                   comments: 0,
                   user_id: 10_692_069,
                   user: 'sueegeneris',
                   userImageURL: 'https://cdn.pixabay.com/user/2018/12/09/04-43-03-766_250x250.jpg' }

    image = Image.new(image_data)

    expect(image).to be_a Image
    expect(image.id).to eq(image_data[:id])
    expect(image.tags).to eq(image_data[:tags])
    expect(image.image_path).to eq(image_data[:webformatURL])
    expect(image.artist).to eq("https://pixabay.com/users/#{image_data[:user]}-#{image_data[:user_id]}/")
  end
end
