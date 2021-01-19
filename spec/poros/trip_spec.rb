require 'rails_helper'

describe Trip, type: :model do
  before :each do
    @trip_data =
      {
        start_city: 'Seattle, WA',
        end_city: 'Denver, CO',
        travel_time: 76_126,
        depart_time: 1_610_971_811,
        arrival_time: 1_611_051_537,
        weather_at_eta: {
          dt: 1_611_158_400,
          temp: 275.51,
          feels_like: 270.84,
          pressure: 1020,
          humidity: 68,
          dew_point: 262.9,
          uvi: 0.62,
          clouds: 0,
          visibility: 10_000,
          wind_speed: 3.27,
          wind_deg: 202,
          weather: [{ id: 800, main: 'Clear', description: 'clear sky', icon: '01d' }],
          pop: 0
        }
      }
    @trip = Trip.new(@trip_data)
  end
  it 'has attributes' do
    expect(@trip).to be_a Trip
    expect(@trip.start_city).to eq(@trip_data[:start_city])
    expect(@trip.end_city).to eq(@trip_data[:end_city])
    expect(@trip.loc_arr_time).to eq(Time.at(@trip_data[:arrival_time]))
    expect(@trip.travel_time).to eq("21 hours, 8 minutes")
    expect(@trip.weather_at_eta).to be_a WeatherHour
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
