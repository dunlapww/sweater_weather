require 'rails_helper'

describe 'when I receive a request to create a new user' do
  before :each do
    @user1 = User.create({email: 'new_user@email.com',password: 'abc123',password_confirmation: 'abc123'})
  end
  it "I'm able to consume the json body" do
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'person@woohoo.com',password: 'abc123',password_confirmation: 'abc123'}
    
    #below passes in data in request.body, but also in params
    #post '/api/v1/users', params: params.to_json
    
    #below passes in data in request.body, but also in params
    post '/api/v1/users', params: params.to_json, headers: headers
    
    #below does not work, 'ArgumentError: unknown keyword: body'
    #post '/api/v1/users', body: params.to_json, headers: headers
    
    #below does not work...request.body is an empty string.
    # post '/api/v1/users' do |req|
    #    req.body = params
    #    req.headers = headers
    # end
    expect(response).to be_successful
    resp = JSON.parse(response.body, symbolize_names: true)
    expect(resp).to be_a Hash
    expect(resp).to have_key(:data)
    expect(resp[:data]).to be_a Hash
    expect(resp[:data]).to have_key(:id)
    expect(resp[:data][:id].to_i).to be_a Integer
    expect(resp[:data]).to have_key(:type)
    expect(resp[:data][:type]).to eq('user')
    expect(resp[:data]).to have_key(:attributes)
    expect(resp[:data][:attributes]).to be_a Hash
    expect(resp[:data][:attributes]).to have_key(:email)
    expect(resp[:data][:attributes][:email]).to be_a String
    expect(resp[:data][:attributes]).to have_key(:api_key)
    expect(resp[:data][:attributes][:api_key]).to be_a String
  end
  it "expect an error hash if user name already taken" do   
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'new_user@email.com',password: 'abc123',password_confirmation: 'abc123'}
    
    post '/api/v1/users', params: params.to_json, headers: headers
    
    expect(response).to be_successful
    resp = JSON.parse(response.body, symbolize_names: true)
    expect(resp).to eq({:errors=>[{:detail=>"Email has already been taken"}]})
  end
  it "expect an error hash if passwords don't match" do   
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'will@email.com',password: 'abc124',password_confirmation: 'abc123'}
    
    post '/api/v1/users', params: params.to_json, headers: headers
    
    expect(response).to be_successful
    resp = JSON.parse(response.body, symbolize_names: true)
    expect(resp).to eq({:errors=>[{:detail=>"Password confirmation doesn't match Password"}]})
  end
end
