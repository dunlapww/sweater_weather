class UnsplashService
  def self.conn
    Faraday.new('https://api.unsplash.com') do |req|
      req.headers['Authorization'] = "Client-ID #{ENV['UNSPLASH_API_KEY']}"
      req.headers['Accept-Version'] = 'v1'
    end
  end

  def self.get_image(params)
    response = conn.get('/search/photos') do |req|
      req.params[:query] = "#{params[:location]} city"
    end
    image_data = JSON.parse(response.body, symbolize_names: true)
    
    image_data[:total].zero? ? default_img_data : image_data[:results].sample
  end

  def self.default_img_data
    json_data = File.read('app/default_image/sunset_image.json')
    image_data = JSON.parse(json_data, symbolize_names: true)
  end
end
