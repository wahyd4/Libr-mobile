libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal', 'AuthService', '$state', '$cacheFactory', 'LocalStorageUtils']
  constructor: (@$scope, @$ionicModal, @AuthService, @$state, @$cacheFactory, @LocalStorageUtils) ->
    @$scope.logout = @logout
    @$scope.feedback = @feedback
    @$scope.showMe = @showMe
    if isUserLogedIn(@LocalStorageUtils) then @$scope.isLogedIn = true else @$scope.isLogedIn = false
    @$scope.avatar = @LocalStorageUtils.getUserAvatar()
    @$scope.username = @LocalStorageUtils.getUserName()


  logout: =>
    localStorage.clear()
    httpDefaultCache = @$cacheFactory.get '$http'
    console.log 'cacheFactory', httpDefaultCache
    httpDefaultCache.removeAll()
    @$state.go 'login'

  feedback: ->
    window.open('https://jinshuju.net/f/F96z3s', '_blank', 'location=no')

  showMe: ->
    window.open('http://libr.herokuapp.com', '_blank', 'location=no')

  isUserLogedIn = (localStorageUtils)->
    if localStorageUtils.getUserToken() isnt null and localStorageUtils.getUserEmail() isnt null
      true
    else
      false


libr.controller 'SettingsController', SettingsController