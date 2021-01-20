class Image
  attr_reader :id,
              :image_path,
              :tags,
              :artist

  def initialize(image_data)
    @id = image_data[:id]
    @curator = "https://unsplash.com/"
    @artist_link = "https://pixabay.com/users/#{image_data[:user]}-#{image_data[:user_id]}/"
    @image_path = image_data[:webformatURL]
    @alt_description = image_data[:tags]
  end
end
