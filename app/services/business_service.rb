class BusinessService
  def self.conn
    Faraday.new('https://api.yelp.com') do |req|
      req.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def self.get_business(params, arrival_time)
    response = conn.get('/v3/businesses/search') do |req|
      req.params[:location] = params[:destination]
      req.params[:term] = params[:search_terms]
      req.params[:open_at] = arrival_time
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  

end