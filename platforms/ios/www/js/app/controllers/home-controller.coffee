libr = angular.module 'libr.controllers.home', ['ionic']

class HomeController
  @$inject: ['$scope', '$location', 'BookService', 'ScanService', '$ionicLoading']

  constructor: (@$scope, @$location, BookService, ScanService, @$ionicLoading)->
    if isUserLogedIn()
      showLoading(@$scope, @$ionicLoading)
      BookService.getBooks().success (result)=>
        @$scope.books = result.books
        @$scope.enableBackButton = false
        @$scope.rightButtons = [
          {
            type: 'button-icon icon ion-camera'
            tap: (e) ->
              ScanService.scan()
          }
        ]
        @$scope.loading.hide();
    else
      console.log 'ssssssssssssss'
      @$location.path '/tab/settings'
      return

  showLoading = ($scope, $ionicLoading)->
    $scope.loading = $ionicLoading.show {
      content: '加载中',
      animation: 'fade-in',
      showBackdrop: true,
      maxWidth: 200,
      showDelay: 500
    }
  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false
libr.controller 'HomeCtrl', HomeController