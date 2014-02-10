// Generated by CoffeeScript 1.6.3
(function() {
  var LocationController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.location', ['ionic']);

  LocationController = (function() {
    LocationController.$inject = ['$scope', '$location', 'GeolocationService'];

    function LocationController($scope, $location, GeolocationService) {
      var _this = this;
      this.$scope = $scope;
      this.$location = $location;
      this.GeolocationService = GeolocationService;
      this.addLocation = __bind(this.addLocation, this);
      this.$scope.enableBackButton = false;
      this.$scope.rightButtons = [
        {
          type: 'button-icon icon ion-ios7-plus',
          tap: function(e) {
            return _this.addLocation();
          }
        }
      ];
      this.$scope.itemButtons = [
        {
          text: '删除',
          type: 'button-assertive',
          onTap: function(item) {
            return _this.GeolocationService.deleteLocation(item, function(result) {
              return _this.$scope.locations.splice(_this.$scope.locations.indexOf(item), 1);
            });
          }
        }
      ];
      this.GeolocationService.getLocations(function(locations) {
        return _this.$scope.locations = locations;
      });
      this.GeolocationService.getDetailAddress(function(position) {
        localStorage.setItem('cur_address_detail', position.result.formatted_address);
        localStorage.setItem('cur_lat', position.result.location.lat);
        localStorage.setItem('cur_lng', position.result.location.lng);
        return _this.$scope.address = position.result.formatted_address;
      });
    }

    LocationController.prototype.addLocation = function() {
      var _this = this;
      return this.GeolocationService.createLocation(function(result) {
        return _this.$scope.locations.push(result);
      });
    };

    return LocationController;

  })();

  libr.controller('LocationController', LocationController);

}).call(this);
