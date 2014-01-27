libr = angular.module 'libr.controllers.settings', ['ionic']

class SettingsController

  @$inject: ['$scope', '$ionicModal']
  constructor: (@$scope, @$ionicModal) ->
    @$ionicModal.fromTemplateUrl 'templates/modal/login.html', (modal)=>
      @$scope.modal = modal;
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }
    @$scope.login = @login
    @$scope.closeModal = @closeModal

  login: () =>
    @$scope.modal.show()
  closeModal: ()=>
    @$scope.modal.hide()


libr.controller 'SettingsController', SettingsController