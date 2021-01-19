require 'rails_helper'

describe BusinessTripFacade, type: :facade do
  
  describe 'class methods' do
    it 'get_trip - valid' do
      VCR.use_cassette('business_trip_facade_valid') do
      trip_params = {origin: 'Seattle, WA', destination: 'Pueblo, CO', search_terms: 'tacos'}

        trip = BusinessTripFacade.get_trip(trip_params)
        expect(trip).to be_a BizTrip
      end
    end
    it 'biz_facade_get_trip - no origin' do
      VCR.use_cassette('no_origin_biz_trip_facade') do
        trip_params = {origin: '', destination: 'Pueblo, CO', search_terms: 'tacos'}
        trip = BusinessTripFacade.get_trip(trip_params)
        expect(trip).to be_a Hash
        expected = {:data=>{:attributes=>{:end_city=>"Denver, CO", :start_city=>"", :travel_time=>"impossible", :weather_at_eta=>{}}, :id=>nil, :type=>"roadtrip"}}
        expect(trip).to eq(expected)
      end
    end
    it 'biz_facade_get_trip - bad origin' do
      VCR.use_cassette('no_origin_biz_trip_facade') do
        trip_params = {origin: '/', destination: 'Pueblo, CO', search_terms: 'tacos'}
        trip = BusinessTripFacade.get_trip(trip_params)
        expect(trip).to be_a Hash
        expected = {:data=>{:attributes=>{:end_city=>"Denver, CO", :start_city=>"", :travel_time=>"impossible", :weather_at_eta=>{}}, :id=>nil, :type=>"roadtrip"}}
        expect(trip).to eq(expected)
      end
    end
  end
end