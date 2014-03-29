libr = angular.module 'libr.controllers.books', ['ionic']

class BooksController

  @$inject: ['$scope', 'Books', 'ScanService', '$ionicModal', 'DoubanService']
  constructor: (@$scope, @Books, @ScanService, @$ionicModal, @DoubanService) ->
    currentPage = localStorage.setItem 'user_books_current_page', 0
    @$scope.books = []
    @$scope.moreItemsAvailable = true
    @$scope.submitAllowed = true

    @$ionicModal.fromTemplateUrl 'templates/modal/import_books.html', (modal)=>
      @$scope.modal = modal
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }

    @$scope.onRefresh = @refresh
    @$scope.loadMore = @loadMore
    @$scope.closeDialog = @closeDialog
    @$scope.searchDoubanUser = @searchDoubanUser
    @$scope.scanBooks = @scanBooks
    @$scope.submitDoubanUser = @submitDoubanUser

    @$scope.doubanInputDisabled = false

  refresh: ()=>
    afterBookId = localStorage.getItem 'user_max_book_id'
    @Books.fetchNew {afterId: afterBookId}, (data)=>
      @$scope.$broadcast('scroll.refreshComplete')
      if data.books.length isnt 0
        localStorage.setItem 'user_max_book_id', data.books[0].id
        data.books.forEach (item, index, array)=>
          @$scope.books.push item

  loadMore: ()=>
    currentPage = localStorage.getItem 'user_books_current_page'
    maxPage = localStorage.getItem 'user_books_max_page'
    maxPage = parseInt maxPage
    currentPage = parseInt currentPage

    unless currentPage >= maxPage
      @Books.query {page: currentPage + 1}, (data) =>
        unless data.books.length is 0
          localStorage.setItem 'user_max_book_id', data.books[0].id
          localStorage.setItem 'user_books_current_page', data.current_page
          localStorage.setItem 'user_books_max_page', data.total_page
          data.books.forEach (item, index, array)=>
            @$scope.books.push item
        else
          @$scope.moreItemsAvailable = false
        @$scope.$broadcast('scroll.infiniteScrollComplete')

    else
      @$scope.$broadcast('scroll.infiniteScrollComplete')
      @$scope.moreItemsAvailable = false

  closeDialog: =>
    @$scope.modal.hide()

  searchDoubanUser: (user)=>
    if user is undefined or user.trim() is ''
      alert '请输入有效昵称'
    else
      @DoubanService.userInfo user,
      (data)=>
        @$scope.resultEnabled = true
        @$scope.submitAllowed = true
        @$scope.doubanUser = data
      , (error)=>
        console.log error
        @$scope.resultEnabled = false
        @$scope.submitAllowed = false


  scanBooks: ()=>
    @ScanService.scan (result)=>
      navigator.notification.alert "添加图书《#{result.book.name}》成功", null, "Libr", "确定"
      @$scope.books.unshift result.book

  submitDoubanUser: =>
    username = angular.element document.getElementById('douban-username')
    username = username.val()
    @DoubanService.submitUser username, (data) =>
      @$scope.doubanInputDisabled = true
      alert '成功绑定豆瓣用户'

      , (data)->
        alert '绑定豆瓣用户失败，请稍后再试'

libr.controller 'BooksController', BooksController
