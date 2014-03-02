libr = angular.module('libr.controllers', [])

class BookDetailController
  @$inject: ['$scope', '$stateParams', 'BookService', '$window']

  constructor: (@$scope, @$stateParams, @BookService, $window)->
    BookService.getBook(@$stateParams.isbn).success (result) =>
      @$scope.book = result
      @$scope.bookName = @$scope.book.name
      @$scope.enableBackButton = true
      @$scope.rightButtons = []
      @$scope.leftButtons = [
        {
          type: 'button-icon icon ion-ios7-plus'
          tap: =>
            $window.history.back();
          swipe: =>
            alert 'swipe triggered'
        }
      ]
      console.log @$scope
      return

libr.controller 'BookDetailController', BookDetailController

