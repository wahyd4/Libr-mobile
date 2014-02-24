libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal', 'AuthService', '$state']
  constructor: (@$scope, @$ionicModal, @AuthService, @$state) ->
    @$ionicModal.fromTemplateUrl 'templates/modal/login.html', (modal)=>
      @$scope.modal = modal;
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }
    @$scope.loginForm = @loginForm
    @$scope.closeModal = @closeModal
    @$scope.login = @login
    @$scope.logout = @logout
    if isUserLogedIn() then @$scope.isLogedIn = true else @$scope.isLogedIn = false

  loginForm: ()=>
    @$scope.modal.show()
  closeModal: ()=>
    @$scope.modal.hide()

  login: (user)=>
    console.log user
    @AuthService.login user, (result)=>
      localStorage.setItem 'token', result.token
      localStorage.setItem 'email', user.email
      @closeModal()

  logout: ->
    localStorage.removeItem 'email'
    localStorage.removeItem 'token'
    @$state.go 'login'

  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false


libr.controller 'SettingsController', SettingsController