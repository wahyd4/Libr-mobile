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


libr.controller 'BooksController', BooksController