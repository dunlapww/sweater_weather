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
    JSON.parse(response.body, symbolize_names: true)
  end
end