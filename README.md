# sweater_weather
An API that exposes several endpoints for geographic, image, and weather data. It uses the MapQuest, Unsplash, and OpenWeather API's to do so.  This is a project I completed at the Turing school to achieve several learning goals:
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

## Setup
This app has not been deployed to a production environment.  To setup for local use, from your shell:

1. `$git clone git@github.com:dunlapww/sweater_weather.git`
2. `$bundle`
3. `$rails db{create, migrate}`

Details for setting up each end point in Postman can be found in the End Points section.


## End Points

### Forecast Endpoint
Allows the user to enter a city,state and it will return the forecast for the location.  It does this by first getting the coordinates from MapQuest and then using those coordinates to get the forecast from the OpenWeather API.  This endpoint returns current forecast, 8 hours of forecasted weather, and 5 days of daily weather

##### Forecast route detail and postman example w response
- Route: `GET api/v1/forecast`
- Headers: na
- Params: `location (city/state)`
- example: `http://localhost:3000/api/v1/forecast?location=Seattle, WA`

![](app/read_me_data/forecast_endpoint.png "Forecast endpoint")

### Backgrounds Endpoint
Allows the user to enter a city,state and it will return an image associated with the city.  It utilizes the Unsplash image search API to do so.  

##### Backgrounds route detail and postman example w response
- Route: `GET pi/v1/backgrounds`
- Headers: na
- Params: `location (city,state)`
- example: `http://localhost:3000/api/v1/backgrounds?location=Seattle, WA`

![](app/read_me_data/backgrounds_endpoint.png "backgrounds endpoint")

### Users Endpoint
This endpoint takes json stored in the body of the HTTP request and creates a new user in the system if the email is not taken and the password and password confirmation match.  It returns to the Front End a json that contains the user's email a unique API key that they can use instantiate sessions in the future.

##### Users route detail and postman example w response
- Route: `POST api/v1/users`
- Headers:
  - `'Content-Type':'application/json'`
  - `'Accept':'application/json'`
- Params: na
- Body: json with email, password, password_confirmation.
```
example body:
  {
    "email":"will@woohoo.com",
"password":"abc123",
"password_confirmation":"abc123"
}
```

![](app/read_me_data/users_endpoint.png "users endpoint")

### Sessions Endpoint
- Route: `api/v1/sessions`

This endpoint takes json stored in the body of the HTTP request (an email and their password) and creates a new session in the system for the user as long as they provide valid login credentials.  Like creating a new user, a successful response body is a json that contains the user's email and their API key.

##### Sessions route detail and postman example w response
- Route: `POST api/v1/sessions`
- Headers:
  - `'Content-Type':'application/json'`
  - `'Accept':'application/json'`
- Params: na
- Body: json with email, password
```
example body:
  {
    "email":"will@woohoo.com",
"password":"abc123"
}
```

![](app/read_me_data/sessions_endpoint.png "session endpoint")



### RoadTrips Endpoint
POST `api/v1/road_trip`

This endpoint takes json stored in the body of the HTTP request (an origin and destination city/state, and their API key).  If their API key is valid, the successful response contains the origin and destination detail, expected travel time to the destination (by car), and the expected weather upon their arrival.

##### Sessions route detail and postman example w response
- Route: `POST api/v1/road_trip`
- Headers:
  - `'Content-Type':'application/json'`
  - `'Accept':'application/json'`
- Params: na
- Body: json with origin (city,state), destination(city,state), user api key
```
example body:
  {
    "origin":"Denver, CO",
"destination":"Boulder, CO",
"api_key":"d383a09c-15a4-41bc-abad-112b87ce97ac"
}
```

![](app/read_me_data/road_trip_endpoint.png "road_trip endpoint")




