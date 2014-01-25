libr = angular.module('starter.controllers', [])

class MainController
  @$inject: ['$scope', '$location']

  constructor: (@$scope, @$location) ->
    console.log 'init...'

  goTo: (page) ->
    @$scope.sideMenuController.toggleRight()
    @$location.url('/' + page)

class HomeController
  @$inject: ['$scope', '$location', 'BookService', 'ScanService']

  constructor: (@$scope, @$location, BookService, ScanService)->
    BookService.getBooks().success (result)=>
      @$scope.books = result.books
      @$scope.enableBackButton = false
      @$scope.rightButtons = [
        {
          type: 'button-icon icon ion-navicon',
          tap: (e)->
            $scope.sideMenuController.toggleRight()
        }
      ]
      @$scope.leftButtons = [
        {
          type: 'button-icon icon ion-camera'
          tap: (e) ->
            ScanService.scan()
        }
      ]


class BookDetailController
  @$inject: ['$scope', '$stateParams', 'BookService']

  constructor: (@$scope, @$stateParams, @BookService)->
    BookService.getBook(@$stateParams.isbn).success (result) =>
      @$scope.book = result
      @$scope.enableBackButton = true;
      @$scope.rightButtons = [
        {
          type: 'button-icon icon ion-navicon',
          tap: (e)->
            @$scope.sideMenuController.toggleRight()
        }
      ]
      @$scope.leftButtons = [];
      @$scope.bookName = result.name


libr.controller 'BookDetailController', BookDetailController
libr.controller 'HomeCtrl', HomeController
libr.controller 'MainCtrl', MainController

