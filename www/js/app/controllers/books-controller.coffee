libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope', 'Books']
  constructor: (@$scope, @Books)->
    console.log '==', @Books.query {}, (data)=>
      @$scope.books = data.books

libr.controller 'BooksController', BooksController