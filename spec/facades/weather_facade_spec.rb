require 'rails_helper'

describe WeatherFacade, type: :facade do
  it 'can return a Forecast object' do
    VCR.use_cassette('good_facade_call') do
      facade = WeatherFacade.get_weather("Seattle, WA")
      expect(facade).to be_a Forecast
    end
  end
  
  it 'can return and error hash if bad data' do
    VCR.use_cassette('bad_facade_call') do
      facade = WeatherFacade.get_weather("")
      expect(facade).to have_key(:errors)
    end
    VCR.use_cassette('another_bad_facade_call') do
      facade = WeatherFacade.get_weather("-")
      expect(facade).to have_key(:errors)
    end
  end
end