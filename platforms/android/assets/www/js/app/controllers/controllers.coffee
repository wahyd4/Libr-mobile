libr = angular.module('libr.controllers', ['ionic'])

class BookDetailController
  @$inject: ['$scope', '$stateParams', 'Books', '$window', '$ionicModal', 'Comments', 'DoubanService']
  constructor: (@$scope, @$stateParams, @Books, @$window, @$ionicModal, @Comments, @DoubanService) ->
    @$scope.openDialog = @openCommentDialog
    @$scope.closeDialog = @closeCommentDialog
    @$scope.doComment = @doComment
    @$scope.back = @back

    @$ionicModal.fromTemplateUrl 'templates/modal/comment.html', (modal)=>
      @$scope.modal = modal
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }
    @Books.get {book_id: @$stateParams.isbn},
    (result) =>
      @$scope.book = result
      @$scope.usersAccount = result.users.length
      @$scope.bookName = @$scope.book.name
      @Comments.query {book_id: result.id}, (data)=>
        console.log data, '!!!!!'
        @$scope.comments = data
      @DoubanService.bookDetail result.isbn, (data)=>
        console.log data
        @$scope.bookDetail = data
      , (error)->
        console.log 'error', error

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
      @Comments.save {
        book_id: @$scope.book.id
        content: text
      }, null, (data)=>
        if data.id is null
          alert '添加图书失败'
        else
          console.log '成功。。。。。。。'
          @$scope.comments.push data
          @closeCommentDialog()

  back: ()=>
    @$window.history.back()


libr.controller 'BookDetailController', BookDetailController
