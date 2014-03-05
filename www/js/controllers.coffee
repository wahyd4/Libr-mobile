libr = angular.module('libr.controllers', ['ionic'])

class BookDetailController
  @$inject: ['$scope', '$stateParams', 'BookService', '$window', '$ionicModal', 'Comments']

  constructor: (@$scope, @$stateParams, @BookService, $window, @$ionicModal, @Comments) ->
    @$scope.openDialog = @openCommentDialog
    @$scope.closeDialog = @closeCommentDialog
    @$scope.doComment = @doComment

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
      @Comments.query {book_id: result.id}, (data)->
        @$scope.comments = data


    @$scope.$on '$destroy', ()=>
      @$scope.modal.remove()


  openCommentDialog: ()=>
    @$scope.modal.show()
  closeCommentDialog: ()=>
    @$scope.modal.hide()
  doComment: ()=>
    text = angular.element(document.getElementById('comment')).val()
    if text.trim() is ''
      alert '请输入有效字符'
      return false
    else


libr.controller 'BookDetailController', BookDetailController

