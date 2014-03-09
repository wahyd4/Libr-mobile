libr = angular.module 'libr.controllers.login', ['ionic']

class LoginController

  @$inject: ['$scope', 'AuthService', '$state']
  constructor: (@$scope, @AuthService, @$state)->
    if isUserLogedIn() then @$state.go('tab.home')
    @$scope.login = @login

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


libr.controller 'LoginController', LoginController