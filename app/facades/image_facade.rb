class ImageFacade
  def self.get_image(location)
    image_data = ImageService.get_image(location)
    Image.new(image_data[:hits].sample)
  end
end