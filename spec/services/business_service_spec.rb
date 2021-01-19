require 'rails_helper'

describe BusinessService, type: :service do
  describe 'class methods' do
    before :each do
      @user = User.create({ email: 'new_user@email.com', password: 'abc123', password_confirmation: 'abc123' })
      @user = User.find(@user.id)
    end
    it 'get_location' do
      VCR.use_cassette('biz_service_get_business') do
        params = {destination: "Santa Fe, NM", search_terms: 'tacos'}
        arrival_time = 1611059122
        results = BusinessService.get_business(params, arrival_time)
        expect(results).to be_a Hash
        expect(results[:businesses]).to be_a Array
        expect(results[:businesses].first).to have_key :name
        expect(results[:businesses].first).to have_key :image_url
        expect(results[:businesses].first).to have_key :url
        expect(results[:businesses].first).to have_key :is_closed
        expect(results[:businesses].first).to have_key :rating
        expect(results[:businesses].first).to have_key :coordinates
        expect(results[:businesses].first).to have_key :location
        expect(results[:businesses].first[:location]).to have_key :display_address
        expect(results[:businesses].first).to have_key :display_phone
      end
    end
  end
end