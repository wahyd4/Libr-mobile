libr = angular.module 'libr.controllers.location', ['ionic']

class LocationController

  @$inject: ['$scope', '$location', 'GeolocationService', 'IonicUtils']

  constructor: (@$scope, @$location, @GeolocationService, @IonicUtils) ->
    @$scope.addLocation = @addLocation
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

    @IonicUtils.initCustomLoading(@$scope)
    @$scope.deleteItem = @deleteItem

  addLocation: () =>
    if @$scope.locations.length >= 3
      @IonicUtils.showLoading(@$scope, '只能创建3个常用的地址，请先删除部分再添加')
    else if (localStorage.getItem('cur_address_detail') is null) || (localStorage.getItem('cur_address_detail') is undefined)
      @IonicUtils.showLoading(@$scope, '定位成功后方可添加常用地址')
    else if (@$scope.address is null or @$scope.address is '')
      @IonicUtils.showLoading(@$scope, '定位成功后方可添加常用地址')
    else
      @GeolocationService.createLocation (result)=>
        @$scope.locations.push result

  deleteItem: (item)=>
    @GeolocationService.deleteLocation item, (result)=>
      @$scope.locations.splice @$scope.locations.indexOf(item), 1

libr.controller 'LocationController', LocationController