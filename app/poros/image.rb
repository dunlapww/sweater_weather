class Image
  attr_reader :id, 
              :image_path, 
              :tags,
              :artist
  
  def initialize(image_data)
    @id = image_data[:id]
    @image_path = image_data[:webformatURL]
    @tags = image_data[:tags]
    @artist = "https://pixabay.com/users/#{image_data[:user]}-#{image_data[:user_id]}/"
  end
end