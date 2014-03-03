libr = angular.module 'libr.controllers.location', ['ionic']

class LocationController

  @$inject: ['$scope', '$location', 'GeolocationService']

  constructor: (@$scope, @$location, @GeolocationService) ->
    @$scope.enableBackButton = false
    @$scope.rightButtons = [
      {
        type: 'button icon ion-ios7-plus'
        tap: (e) =>
          @addLocation()
      }
    ]
    @$scope.itemButtons = [
      {
        text: '删除',
        type: 'button-assertive',
        onTap: (item)=>
          @GeolocationService.deleteLocation item, (result)=>
            @$scope.locations.splice @$scope.locations.indexOf(item), 1
      }
    ]
    @GeolocationService.getLocations (locations)=>
      @$scope.locations = locations
    @GeolocationService.getDetailAddress (position)=>
      localStorage.setItem 'cur_address_detail', position.result.formatted_address
      localStorage.setItem 'cur_lat', position.result.location.lat
      localStorage.setItem 'cur_lng', position.result.location.lng
      @$scope.address = position.result.formatted_address

  addLocation: () =>
    if @$scope.locations.length >= 3
      alert '只能创建3个常用的地址哦，你可以尝试删除部分，再添加'
    else
      @GeolocationService.createLocation (result)=>
        @$scope.locations.push result


libr.controller 'LocationController', LocationController