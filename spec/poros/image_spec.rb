require 'rails_helper'

describe Image, type: :model do
  it 'has attributes' do
    image_data = {
      id: nil,
      tags: 'no city image found',
      webformatURL: 'https://cdn.pixabay.com/photo/2020/06/16/19/28/sunset-5306985_960_720.jpg'
    }
    image = Image.new(image_data)

    expect(image).to be_a Image
    expect(image.id).to eq(image_data[:id])
    expect(image.tags).to eq(image_data[:tags])
    expect(image.image_path).to eq(image_data[:webformatURL])
  end
end