libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope', 'Books', 'ScanService']
  constructor: (@$scope, @Books, ScanService)->
    @Books.query {}, (data)=>
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

  refresh: ()=>
    @Books.query {}, (data)=>
#      unless data.books[0].name is @$scope.books[0].name
#        @$scope.books.unshift data.books
#      else
    alert '没有新书了。。。'


libr.controller 'BooksController', BooksController