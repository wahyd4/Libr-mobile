(function() {
  var LocationController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.location', ['ionic']);

  LocationController = (function() {
    LocationController.$inject = ['$scope', '$location', 'GeolocationService', 'IonicUtils'];

    function LocationController($scope, $location, GeolocationService, IonicUtils) {
      this.$scope = $scope;
      this.$location = $location;
      this.GeolocationService = GeolocationService;
      this.IonicUtils = IonicUtils;
      this.addLocation = __bind(this.addLocation, this);
      this.$scope.addLocation = this.addLocation;
      this.$scope.itemButtons = [
        {
          text: '删除',
          type: 'button-assertive',
          onTap: (function(_this) {
            return function(item) {
              return _this.GeolocationService.deleteLocation(item, function(result) {
                return _this.$scope.locations.splice(_this.$scope.locations.indexOf(item), 1);
              });
            };
          })(this)
        }
      ];
      this.GeolocationService.getLocations((function(_this) {
        return function(locations) {
          return _this.$scope.locations = locations;
        };
      })(this));
      this.GeolocationService.getDetailAddress((function(_this) {
        return function(position) {
          localStorage.setItem('cur_address_detail', position.result.formatted_address);
          localStorage.setItem('cur_lat', position.result.location.lat);
          localStorage.setItem('cur_lng', position.result.location.lng);
          return _this.$scope.address = position.result.formatted_address;
        };
      })(this));
      this.IonicUtils.initCustomLoading(this.$scope);
    }

    LocationController.prototype.addLocation = function() {
      if (this.$scope.locations.length >= 3) {
        return this.IonicUtils.showLoading(this.$scope, '只能创建3个常用的地址哦，你可以尝试删除部分，再添加');
      } else if (localStorage.getItem('cur_address_detail') === null) {
        return this.IonicUtils.showLoading(this.$scope, '定位成功后方可添加常用地址');
      } else {
        return this.GeolocationService.createLocation((function(_this) {
          return function(result) {
            return _this.$scope.locations.push(result);
          };
        })(this));
      }
    };

    return LocationController;

  })();

  libr.controller('LocationController', LocationController);

}).call(this);
