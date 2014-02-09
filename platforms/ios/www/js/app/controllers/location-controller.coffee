libr = angular.module 'libr.controllers.location', []

class LocationController

  @$inject: ['$scope', '$location', 'GeolocationService']

  constructor: (@$scope, @$location, GeolocationService) ->
    @$scope.enableBackButton = false
    @$scope.rightButtons = [
      {
        type: 'button-icon icon ion-ios7-plus'
        tap: (e) ->
          alert('add location')
      }
    ]
    GeolocationService.getLocations (locations)=>
      @$scope.locations = [
        {
          name: 'xx'
        },
        {
          name: 'yy'
        }
      ]
    GeolocationService.getDetailAddress (position)=>
      localStorage.setItem 'address_detail', position.result.formatted_address
      @$scope.address = position.result.formatted_address


libr.controller 'LocationController', LocationController