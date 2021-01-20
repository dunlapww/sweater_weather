# sweater_weather
An API that exposes several endpoints for geographic, image, and weather data. It uses the MapQuest, Unsplash, and OpenWeather API's to do so.  This is a project I completed at the Turing school to achieve several learning goals:
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

## End Points

### Forecast Endpoint
GET `api/v1/forecasts`
Allows the user to enter a city,state and it will return the forecast for the location.  It does this by first getting the coordinates from MapQuest and then using those coordinates to get the forecast from the OpenWeather API.  This endpoint returns current forecast, 8 hours of forecasted weather, and 5 days of daily weather




