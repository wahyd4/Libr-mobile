libr = angular.module('libr.controllers.main', ['ionic'])

class MainController
  @$inject: ['$scope', '$location', '$ionicModal']

  constructor: (@$scope, @$location, @$ionicModal) ->


libr.controller 'MainCtrl', MainController

