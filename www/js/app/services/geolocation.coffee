libr = angular.module 'libr.services.geolocation', []

class GeolocationService
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

  getCurrentLocation: (callback)->
    navigator.geolocation.getCurrentPosition(callback, onError);
    return

libr.service 'GeolocationService', GeolocationService
