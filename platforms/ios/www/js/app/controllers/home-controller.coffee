libr = angular.module 'libr.controllers.home', []

class HomeController
  @$inject: ['$scope', '$location', 'BookService', 'ScanService']

  constructor: (@$scope, @$location, BookService, ScanService)->
    BookService.getBooks().success (result)=>
      @$scope.books = result.books
      @$scope.enableBackButton = false
      @$scope.leftButtons = []
      @$scope.rightButtons = [
        {
          type: 'button-icon icon ion-camera'
          tap: (e) ->
            ScanService.scan()
        }
      ]

libr.controller 'HomeCtrl', HomeController