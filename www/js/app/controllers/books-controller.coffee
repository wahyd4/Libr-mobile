libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope', 'Books', 'ScanService']
  constructor: (@$scope, @Books, ScanService)->
    @Books.query {}, (data)=>
      @$scope.books = data.books
    @$scope.rightButtons = [
      {
        type: 'button  icon ion-camera'
        tap: (e) ->
          ScanService.scan (result)->
            console.log '成功回调。。。'
            alert "添加图书《#{result.book.name}》成功"

      }
    ]


libr.controller 'BooksController', BooksController