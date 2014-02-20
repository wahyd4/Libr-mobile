libr = angular.module('libr.controllers.main', ['ionic'])

class MainController
  @$inject: ['$scope', '$location', '$ionicModal', '$state']

  constructor: (@$scope, @$location, @$ionicModal, @$state) ->

libr.controller 'MainCtrl', MainController

