libr = angular.module('libr.controllers', [])

class MainController
  @$inject: ['$scope', '$location', 'GeolocationService']

  constructor: (@$scope, @$location, GeolocationService) ->
    console.log 'init...'
    GeolocationService.getCurrentLocation

  goTo: (page) ->
    @$scope.sideMenuController.toggleRight()
    @$location.url('/' + page)


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
libr.controller 'MainCtrl', MainController

