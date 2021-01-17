class Image
  attr_reader :id, 
              :image_path, 
              :tags
  
  def initialize(image_data)
    @id = nil
    @image_path = image_data[:webformatURL]
    @tags = image_data[:tags] 
  end
end