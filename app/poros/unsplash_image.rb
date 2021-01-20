class UnsplashImage
  attr_reader :id,
              :curator,
              :artist_link,
              :artist_name,
              :image_path,
              :alt_description

  def initialize(image_data)
    @id = nil
    @curator = 'https://unsplash.com/'
    @artist_link = image_data[:user][:portfolio_url]
    @artist_name = image_data[:user][:name]
    @image_path = image_data[:urls][:small]
    @alt_description = image_data[:alt_description]
  end
end
