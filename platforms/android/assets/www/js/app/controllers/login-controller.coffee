libr = angular.module 'libr.controllers.login', ['ionic']

class LoginController

  @$inject: ['$scope', 'AuthService', '$state']
  constructor: (@$scope, @AuthService, @$state)->
    if isUserLogedIn() then @$state.go('tab.home')
    @$scope.login = @login
    @$scope.register = @register

  login: (user)=>
    console.log user
    @AuthService.login user, (result)=>
      localStorage.setItem 'token', result.user.token
      localStorage.setItem 'avatar', result.user.avatar
      localStorage.setItem 'username', result.user.name
      localStorage.setItem 'email', user.email
      @$state.go 'tab.home'

  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false

  register: ->
    window.open('http://libr.herokuapp.com/users/sign_up', '_blank', 'location=no')


libr.controller 'LoginController', LoginController