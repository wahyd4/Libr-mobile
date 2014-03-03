libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope', 'Books', 'ScanService', '$timeout']
  constructor: (@$scope, @Books, ScanService)->
    currentPage = localStorage.setItem 'user_books_current_page', 0
    @$scope.books = []
    @$scope.rightButtons = [
      {
        type: 'button  icon ion-camera'
        tap: (e) =>
          ScanService.scan (result)=>
            navigator.notification.alert "添加图书《#{result.book.name}》成功", null, "Libr", "确定"
            @$scope.books.unshift result.book

      }
    ]
    @$scope.onRefresh = @refresh
    @$scope.loadMore = @loadMore

  refresh: ()=>
    afterBookId = localStorage.getItem 'user_max_book_id'
    @Books.fetchNew {afterId: afterBookId}, (data)=>
      @$scope.$broadcast('scroll.refreshComplete');
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
        @$scope.$broadcast('scroll.infiniteScrollComplete');
        unless data.books.length is 0
          localStorage.setItem 'user_books_current_page', data.current_page
          localStorage.setItem 'user_books_max_page', data.total_page
          data.books.forEach (item, index, array)=>
            @$scope.books.push item
    else
      @$scope.$broadcast('scroll.infiniteScrollComplete');


libr.controller 'BooksController', BooksController