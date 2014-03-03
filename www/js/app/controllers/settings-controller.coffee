libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal', 'AuthService', '$state', '$cacheFactory']
  constructor: (@$scope, @$ionicModal, @AuthService, @$state, @$cacheFactory) ->
    @$scope.login = @login
    @$scope.logout = @logout
    @$scope.feedback = @feedback
    if isUserLogedIn() then @$scope.isLogedIn = true else @$scope.isLogedIn = false


  login: (user)=>
    console.log user
    @AuthService.login user, (result)=>
      localStorage.setItem 'token', result.token
      localStorage.setItem 'email', user.email
      @closeModal()

  logout: =>
    localStorage.clear()
    httpDefaultCache = @$cacheFactory.get '$http'
    console.log 'cacheFactory', httpDefaultCache
    httpDefaultCache.removeAll()
    @$state.go 'login'

  feedback: ->
    window.open('https://jinshuju.net/f/F96z3s', '_blank', 'location=no')

  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false


libr.controller 'SettingsController', SettingsController