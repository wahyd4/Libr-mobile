libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal', 'AuthService']
  constructor: (@$scope, @$ionicModal, @AuthService) ->
    @$ionicModal.fromTemplateUrl 'templates/modal/login.html', (modal)=>
      @$scope.modal = modal;
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }
    @$scope.loginForm = @loginForm
    @$scope.closeModal = @closeModal
    @$scope.login = @login
  loginForm: () =>
    @$scope.modal.show()
  closeModal: ()=>
    @$scope.modal.hide()

  login: (user)=>
    console.log user
    @AuthService.login user, (result)=>
      localStorage.setItem 'token', result.token
      @closeModal()


libr.controller 'SettingsController', SettingsController