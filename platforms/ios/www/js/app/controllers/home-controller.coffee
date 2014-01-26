libr = angular.module 'libr.controllers.home', ['ionic']

class HomeController
  @$inject: ['$scope', '$location', 'BookService', 'ScanService', '$ionicLoading']

  constructor: (@$scope, @$location, BookService, ScanService, @$ionicLoading)->
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

  showLoading = ($scope, $ionicLoading)->
    $scope.loading = $ionicLoading.show {
      content: '加载中',
      animation: 'fade-in',
      showBackdrop: true,
      maxWidth: 200,
      showDelay: 500
    }


libr.controller 'HomeCtrl', HomeController