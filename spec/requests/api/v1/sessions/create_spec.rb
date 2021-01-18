require 'rails_helper'

require 'rails_helper'

describe 'when I receive a request to create a new user' do
  it "a user is able to login with valid credentials" do
    user1 = User.create({email: 'new_user@email.com',password: 'abc123',password_confirmation: 'abc123'})
    user1_w_key = User.last    
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'new_user@email.com',password: 'abc123'}
    
    
    post '/api/v1/sessions', params: params.to_json, headers: headers
    
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
    expect(resp[:data][:attributes][:email]).to eq(params[:email])
    expect(resp[:data][:attributes]).to have_key(:api_key)
    expect(resp[:data][:attributes][:api_key]).to eq(user1_w_key.api_key)
  end
  it "expect an error hash if email not found" do   
    
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'new_user@email.com',password: 'abc123'}
    
    post '/api/v1/sessions', params: params.to_json, headers: headers
    
    expect(response.status).to eq(400)
    resp = JSON.parse(response.body, symbolize_names: true)
    expect(resp).to eq({:errors=>[{:detail=>"Invalid credentials"}]})
  end
  
  it "expect an error hash if incorrect password" do 
    user1 = User.create({email: 'new_user@email.com',password: 'abc123',password_confirmation: 'abc123'})

    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'new_user@email.com',password: 'abc124'}
    
    post '/api/v1/sessions', params: params.to_json, headers: headers
    
    expect(response.status).to eq(400)
    resp = JSON.parse(response.body, symbolize_names: true)
    expect(resp).to eq({:errors=>[{:detail=>"Invalid credentials"}]})
  end
    
  end
  