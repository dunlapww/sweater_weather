class UnsplashService
  def self.conn
    Faraday.new('https://api.unsplash.com') do |req|
      req.headers["Authorization"] = "Client-ID #{ENV['UNSPLASH_API_KEY']}"
      req.headers["Accept-Version"] = 'v1'
    end
  end

  def self.get_image(params)
    response = conn.get('/search/photos') do |req|
      req.params[:query] = "#{params[:location]} city"
    end
    image_data = JSON.parse(response.body, symbolize_names: true)
    test = assign_image(image_data)
    require 'pry'; binding.pry
  end

  def self.assign_image(image_data)
    if image_data[:total].zero?
      image_data[:total] += 1
      image_data[:results] << default_image
    end
    image_data[:results].sample
  end

  def self.default_image
    {
      id: nil,
      curator: "https://unsplash.com/",
      artist_link: "https://api.unsplash.com/photos/ESEnXckWlLY",
      artist_name: "no image available for that search"
      image_path: "https://images.unsplash.com/photo-1512641406448-6574e777bec6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNzJ8MHwxfHNlYXJjaHwxfHxzdW5zZXR8ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080",
      alt_description: "no image available for that search"
    }
  end
end
