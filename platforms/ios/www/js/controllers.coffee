libr = angular.module('libr.controllers', [])

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

