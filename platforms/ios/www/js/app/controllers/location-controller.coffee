libr = angular.module 'libr.controllers.location', []

class LocationController

  @$inject: ['$scope']
  constructor: (@$scope)->
    @$scope.location = '成都'

libr.controller 'LocationController', LocationController