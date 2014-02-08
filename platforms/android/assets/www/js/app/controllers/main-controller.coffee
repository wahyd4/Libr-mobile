libr = angular.module('libr.controllers.main', ['ionic'])

class MainController
  @$inject: ['$scope', '$location', 'GeolocationService', '$ionicModal']

  constructor: (@$scope, @$location, GeolocationService, @$ionicModal) ->
    GeolocationService.getDetailAddress (position)=>
      console.log position
      @$scope.address = position.result.formatted_address
    console.log @$scope

libr.controller 'MainCtrl', MainController

