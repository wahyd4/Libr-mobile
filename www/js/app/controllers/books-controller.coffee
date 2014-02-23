libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope', 'Books', 'ScanService']
  constructor: (@$scope, @Books, ScanService)->
    @Books.query {}, (data)=>
      localStorage.setItem 'user_max_book_id', data.books[0].id
      localStorage.setItem 'user_min_book_id', data.books[data.books.length - 1].id
      localStorage.setItem 'user_books_current_page', data.current_page
      @$scope.books = data.books
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

  loadMore: =>
    currentPage = localStorage.getItem 'user_books_current_page'
    @Books.query {page: currentPage + 1}, (data) =>
      if data.books.length is 0
        alert '没有再多的书了...'
      else
        localStorage.setItem 'user_books_current_page', data.current_page
        data.books.forEach (item, index, array)=>
          @$scope.books.push item


libr.controller 'BooksController', BooksController