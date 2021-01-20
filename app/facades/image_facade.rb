class ImageFacade
  def self.get_image(location)
    image_data = UnsplashService.get_image(location)
    UnsplashImage.new(image_data)
  end
end
