require 'rails_helper'

describe Business, type: :poro do
  before :each do
    @biz = { id: '3Edd-08gz7auXvqqM-4Dwg',
            alias: 'vazquez-taco-shop-pueblo',
            name: 'Vazquez Taco Shop',
            image_url: 'https://s3-media2.fl.yelpcdn.com/bphoto/lyudLzs92SPt-UFVDqd1rA/o.jpg',
            is_closed: false,
            url: 'https://www.yelp.com/biz/vazquez-taco-shop-pueblo?adjust_creative=PGjHtIggukj-D3RvaNaPsg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=PGjHtIggukj-D3RvaNaPsg',
            review_count: 33,
            categories: [{ alias: 'mexican', title: 'Mexican' }],
            rating: 4.5,
            coordinates: { latitude: 38.2707358, longitude: -104.599503 },
            transactions: ['delivery'],
            price: '$',
            location: { address1: '604 E 4th St', address2: nil, address3: nil, city: 'Pueblo', zip_code: '81001',
                        country: 'US', state: 'CO', display_address: ['604 E 4th St', 'Pueblo, CO 81001'] },
            phone: '+17195462186',
            display_phone: '(719) 546-2186',
            distance: 2284.522971886835 }
  end
  it 'has attributes' do
    business = Business.new(@biz)
    expect(business).to be_a Business
    expect(business.image_url).to eq(@biz[:image_url])
    expect(business.url).to eq(@biz[:url])
    expect(business.rating).to eq(@biz[:rating])
    expect(business.coordinates).to eq(@biz[:coordinates])
    expect(business.address).to eq(@biz[:location][:display_address].join(', '))
    expect(business.phone).to eq(@biz[:display_phone])
    
  end
end
