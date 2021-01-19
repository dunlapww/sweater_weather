require 'rails_helper'

describe 'when I receive a request to create a new user' do
  it "I'm able to consume the json body" do
    headers = { "CONTENT_TYPE" => "application/json"}
    params = {email: 'person@woohoo.com',password: 'abc123',password_confirmation: 'abc123'}
    
    get '/api/v1/users', params: params.to_json, headers: headers
    
   
    expect(response).to be_successful