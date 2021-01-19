require 'rails_helper'

describe BizTrip, type: :poro do
  before :each do
    @trip_data =
    {:start_city=>"Denver, CO",
      :end_city=>"Pueblo, CO",
      :travel_time=>6262,
      :arrival_time=>1611060697,
      :arrival_business=>
       {:id=>"3Edd-08gz7auXvqqM-4Dwg",
        :alias=>"vazquez-taco-shop-pueblo",
        :name=>"Vazquez Taco Shop",
        :image_url=>"https://s3-media2.fl.yelpcdn.com/bphoto/lyudLzs92SPt-UFVDqd1rA/o.jpg",
        :is_closed=>false,
        :url=>"https://www.yelp.com/biz/vazquez-taco-shop-pueblo?adjust_creative=PGjHtIggukj-D3RvaNaPsg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=PGjHtIggukj-D3RvaNaPsg",
        :review_count=>33,
        :categories=>[{:alias=>"mexican", :title=>"Mexican"}],
        :rating=>4.5,
        :coordinates=>{:latitude=>38.2707358, :longitude=>-104.599503},
        :transactions=>["delivery"],
        :price=>"$",
        :location=>{:address1=>"604 E 4th St", :address2=>nil, :address3=>nil, :city=>"Pueblo", :zip_code=>"81001", :country=>"US", :state=>"CO", :display_address=>["604 E 4th St", "Pueblo, CO 81001"]},
        :phone=>"+17195462186",
        :display_phone=>"(719) 546-2186",
        :distance=>2284.522971886835},
      :weather_at_eta=>
       {:dt=>1611244800,
        :temp=>278.24,
        :feels_like=>272.21,
        :pressure=>1017,
        :humidity=>62,
        :dew_point=>267.46,
        :uvi=>0.73,
        :clouds=>0,
        :visibility=>10000,
        :wind_speed=>5.46,
        :wind_deg=>304,
        :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
        :pop=>0}}
     
    @trip = BizTrip.new(@trip_data)
  end
  it 'has attributes' do
    expect(@trip).to be_a BizTrip
    expect(@trip.start_city).to eq(@trip_data[:start_city])
    expect(@trip.destination_city).to eq(@trip_data[:end_city])
    expect(@trip.loc_arr_time).to eq(Time.at(@trip_data[:arrival_time]))
    expect(@trip.travel_time).to eq("1 hour, 44 minutes")
    expect(@trip.forecast).to be_a WeatherHour
    expect(@trip.restaurant).to be_a Business
  end

  describe 'instance methods' do
    it '#to_hours_mins' do
      expect(@trip.to_hours_mins(-5)).to be_a String
      expect(@trip.to_hours_mins(59)).to eq("0 hours, 0 minutes")
      expect(@trip.to_hours_mins(60)).to eq("0 hours, 1 minute")
      expect(@trip.to_hours_mins(121)).to eq("0 hours, 2 minutes")
      expect(@trip.to_hours_mins(3600)).to eq("1 hour, 0 minutes")
      expect(@trip.to_hours_mins(3661)).to eq("1 hour, 1 minute")
      expect(@trip.to_hours_mins(3782)).to eq("1 hour, 3 minutes")
      expect(@trip.to_hours_mins(7200)).to eq("2 hours, 0 minutes")
      expect(@trip.to_hours_mins(7261)).to eq("2 hours, 1 minute")
      expect(@trip.to_hours_mins(7322)).to eq("2 hours, 2 minutes")
    end

    it 'pl' do
      expect(@trip.pl(0)).to eq('s')
      expect(@trip.pl(1)).to eq(nil)
      expect(@trip.pl(2)).to eq('s')
    end
  end
end
