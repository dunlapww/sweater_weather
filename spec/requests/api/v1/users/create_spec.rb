require 'rails_helper'

describe 'when I receive a request to create a new user' do
  it "I'm able to consume the json body" do
    headers = { "CONTENT_TYPE" => "application/json", "whatevs!!!" => "application/json"}
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
  end
end
