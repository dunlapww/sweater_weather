class Business
  attr_reader :name,
              :image_url,
              :url,
              :rating,
              :coordinates,
              :phone
            
  def initialize(business_data)
    @name = business_data[:name]
    @image_url = business_data[:image_url]
    @url = business_data[:url]
    @rating = business_data[:rating]
    @coordinates = business_data[:coordinates]
    @phone = business_data[:display_phone]
  end
end