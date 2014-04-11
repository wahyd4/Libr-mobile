libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal', 'AuthService', '$state', '$cacheFactory']
  constructor: (@$scope, @$ionicModal, @AuthService, @$state, @$cacheFactory) ->
    @$scope.logout = @logout

  logout: =>
    localStorage.clear()
    httpDefaultCache = @$cacheFactory.get '$http'
    console.log 'cacheFactory', httpDefaultCache
    httpDefaultCache.removeAll()
    @$state.go 'login'

  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false

libr.controller 'SettingsController', SettingsController