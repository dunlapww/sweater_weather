require 'rails_helper'

describe Trip, type: :model do
  before :each do
    @trip_data =
      { start_city: 'Seattle, WA',
        end_city: 'Denver, CO',
        travel_time: 66_163,
        local_arrival_time: '01/20/2021 01:09 PM (local time)',
        weather_at_eta: { dt: 1_611_176_400,
                          temp: 283.72,
                          feels_like: 281.08,
                          pressure: 1011,
                          humidity: 40,
                          dew_point: 264.27,
                          uvi: 1.19,
                          clouds: 0,
                          visibility: 10_000,
                          wind_speed: 0.46,
                          wind_deg: 185,
                          weather: [{ id: 800, main: 'Clear', description: 'clear sky', icon: '01d' }],
                          pop: 0 } }

    @trip = Trip.new(@trip_data)
  end
  it 'has attributes' do
    expect(@trip).to be_a Trip
    expect(@trip.start_city).to eq(@trip_data[:start_city])
    expect(@trip.end_city).to eq(@trip_data[:end_city])
    expect(@trip.loc_arr_time).to eq('01/20/2021 01:09 PM (local time)')
    expect(@trip.travel_time).to eq('18 hours, 22 minutes')
    expect(@trip.weather_at_eta).to be_a WeatherHour
  end

  describe 'instance methods' do
    it '#to_hours_mins' do
      expect(@trip.to_hours_mins(-5)).to be_a String
      expect(@trip.to_hours_mins(59)).to eq('0 hours, 0 minutes')
      expect(@trip.to_hours_mins(60)).to eq('0 hours, 1 minute')
      expect(@trip.to_hours_mins(121)).to eq('0 hours, 2 minutes')
      expect(@trip.to_hours_mins(3600)).to eq('1 hour, 0 minutes')
      expect(@trip.to_hours_mins(3661)).to eq('1 hour, 1 minute')
      expect(@trip.to_hours_mins(3782)).to eq('1 hour, 3 minutes')
      expect(@trip.to_hours_mins(7200)).to eq('2 hours, 0 minutes')
      expect(@trip.to_hours_mins(7261)).to eq('2 hours, 1 minute')
      expect(@trip.to_hours_mins(7322)).to eq('2 hours, 2 minutes')
    end
    it 'pl' do
      expect(@trip.pl(0)).to eq('s')
      expect(@trip.pl(1)).to eq(nil)
      expect(@trip.pl(2)).to eq('s')
    end
  end
end
