class ImageService
  def self.conn
    Faraday.new('https://pixabay.com/') do |req|
      req.params[:key] = ENV['PIXABAY_API_KEY']
    end
  end

  def self.get_image(params)
    response = conn.get('/api/') do |req|
      req.params[:q] = params[:location]
      req.params[:image_type] = 'photo'
    end
    image_data = JSON.parse(response.body, symbolize_names: true)
    assign_image(image_data)
  end

  def self.assign_image(image_data)
    if image_data[:totalHits] == 0
      image_data[:totalHits]  += 1
      image_data[:hits] << {
        id: nil,
        tags: 'no city image found',
        webformatURL: 'https://cdn.pixabay.com/photo/2020/06/16/19/28/sunset-5306985_960_720.jpg'
      }
    end
    image_data
  end
end
