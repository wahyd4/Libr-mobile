libr = angular.module 'libr.services.geolocation', []

class GeolocationService

  @$inject: ['$http']
  constructor: (@$http)->

  onSuccess = (position)->
    alert 'lat' + position.coords.latitude
    {
    "Latitude": position.coords.latitude
    "Longitude": position.coords.longitude
    "Altitude": position.coords.altitude
    "Accuracy": position.coords.accuracy
    "Altitude Accuracy": position.coords.altitudeAccuracy
    "Heading": position.coords.heading
    "Speed": position.coords.speed
    "Timestamp": position.timestamp
    }

  onError = (error) ->
    throw "code:  #{error.code} \n message: #{error.message}"

  getCurrentLocation: (callback, error)->
    navigator.geolocation.getCurrentPosition(callback, error);

  getDetailAddress: (callback, error) ->
    baseUrl = 'http://libr.herokuapp.com/api/v1/locations/detail'
    this.getCurrentLocation (position)=>
      @$http.get("#{baseUrl}?lat=#{position.coords.latitude}&lng=#{position.coords.longitude}")
      .success (data, status, headers, config)->
          callback data
    , (error)->
      throw Error error

  getLocations: (callback, error) ->
    baseUrl = 'http://libr.herokuapp.com/api/v1/locations'
    email = localStorage.getItem 'email'
    token = localStorage.getItem 'token'
    @$http.get("#{baseUrl}?user_email=#{email}&user_token=#{token}")
    .success (data, status, headers, config)->
        callback data
    .error (data)->
        throw Error error


libr.service 'GeolocationService', GeolocationService
