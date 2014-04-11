(function() {
  var GeolocationService, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.services.geolocation', []);

  GeolocationService = (function() {
    var getLocation, onError, onSuccess;

    GeolocationService.$inject = ['$http', 'Constant'];

    function GeolocationService($http, Constant) {
      this.$http = $http;
      this.Constant = Constant;
      this.getDetailAddress = __bind(this.getDetailAddress, this);
    }

    onSuccess = function(position) {
      alert('lat' + position.coords.latitude);
      return {
        "Latitude": position.coords.latitude,
        "Longitude": position.coords.longitude,
        "Altitude": position.coords.altitude,
        "Accuracy": position.coords.accuracy,
        "Altitude Accuracy": position.coords.altitudeAccuracy,
        "Heading": position.coords.heading,
        "Speed": position.coords.speed,
        "Timestamp": position.timestamp
      };
    };

    onError = function(error) {
      throw "code:  " + error.code + " \n message: " + error.message;
    };

    GeolocationService.prototype.getCurrentLocation = function(callback, error) {
      return navigator.geolocation.getCurrentPosition(callback, error);
    };

    GeolocationService.prototype.getDetailAddress = function(callback, error) {
      var baseUrl;
      baseUrl = this.Constant.baseUrl + '/locations/detail';
      return this.getCurrentLocation((function(_this) {
        return function(position) {
          return _this.$http({
            url: "" + baseUrl + "?lat=" + position.coords.latitude + "&lng=" + position.coords.longitude,
            cache: true,
            method: 'GET'
          }).success(function(data, status, headers, config) {
            return callback(data);
          });
        };
      })(this), function(error) {
        throw Error(error);
      });
    };

    GeolocationService.prototype.getLocations = function(callback, error) {
      var baseUrl, email, token;
      baseUrl = this.Constant.baseUrl + '/locations';
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        url: "" + baseUrl + "?user_email=" + email + "&user_token=" + token,
        method: 'GET',
        cache: false
      }).success(function(data, status, headers, config) {
        return callback(data);
      }).error(function(data) {
        throw Error(error);
      });
    };

    GeolocationService.prototype.createLocation = function(callback) {
      var baseUrl, email, location, token;
      baseUrl = this.Constant.baseUrl + '/locations';
      location = getLocation();
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        method: 'POST',
        url: baseUrl + ("?user_email=" + email + "&user_token=" + token),
        data: "address=" + location.address + "&lat=" + location.lat + "&lng=" + location.lng,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }).success(function(data) {
        return callback(data);
      });
    };

    GeolocationService.prototype.deleteLocation = function(item, callback) {
      var baseUrl, email, token;
      baseUrl = this.Constant.baseUrl + '/locations';
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        method: 'DELETE',
        url: baseUrl + ("?user_email=" + email + "&user_token=" + token + "&id=" + item.id),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }).success(function(data) {
        console.log("=====", data);
        return callback(data);
      });
    };

    getLocation = function() {
      var location;
      location = {};
      location.address = localStorage.getItem('cur_address_detail');
      location.lat = localStorage.getItem('cur_lat');
      location.lng = localStorage.getItem('cur_lng');
      return location;
    };

    return GeolocationService;

  })();

  libr.service('GeolocationService', GeolocationService);

}).call(this);
