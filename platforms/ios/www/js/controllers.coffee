libr = angular.module('libr.controllers', [])

class MainController
  @$inject: ['$scope', '$location', 'GeolocationService']

  constructor: (@$scope, @$location, GeolocationService) ->
    console.log 'init...'
    GeolocationService.getDetailAddress (position)=>
      console.log position
      @$scope.address = position.result.formatted_address
  goTo: (page) ->
    @$location.url('/' + page)


class BookDetailController
  @$inject: ['$scope', '$stateParams', 'BookService']

  constructor: (@$scope, @$stateParams, @BookService)->
    BookService.getBook(@$stateParams.isbn).success (result) =>
      @$scope.book = result
      @$scope.bookName = @$scope.book.name
      @$scope.enableBackButton = true
      @$scope.rightButtons = []
      @$scope.leftButtons = []
      console.log @$scope
      return


libr.controller 'BookDetailController', BookDetailController
libr.controller 'MainCtrl', MainController

