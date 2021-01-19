class BusinessService
  def self.conn
    Faraday.new('https://api.yelp.com') do |req|
      req.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def self.get_business(params)
    response = conn.get('/v3/businesses/search') do |req|
      req.params[:location] = params[:location]
      req.params[:term] = params[:search_terms]
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end
  

end