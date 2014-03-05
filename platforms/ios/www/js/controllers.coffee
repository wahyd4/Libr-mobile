libr = angular.module('libr.controllers', ['ionic'])

class BookDetailController
  @$inject: ['$scope', '$stateParams', 'BookService', '$window', '$ionicModal']

  constructor: (@$scope, @$stateParams, @BookService, $window, @$ionicModal) ->
    @$scope.openDialog = @openCommentDialog
    @$scope.closeDialog = @closeCommentDialog

    @$scope.rightButtons = []
    @$scope.leftButtons = [
      {
        type: 'button-icon icon ion-arrow-left-c'
        tap: =>
          $window.history.back()
      }
    ]
    @$ionicModal.fromTemplateUrl 'templates/modal/comment.html', (modal)=>
      @$scope.modal = modal
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }
    BookService.getBook(@$stateParams.isbn).success (result) =>
      @$scope.book = result
      @$scope.bookName = @$scope.book.name

    @$scope.$on '$destroy', ()=>
      @$scope.modal.remove()

  openCommentDialog: ()=>
    @$scope.modal.show()
  closeCommentDialog: ()=>
    @$scope.modal.hide()



libr.controller 'BookDetailController', BookDetailController

