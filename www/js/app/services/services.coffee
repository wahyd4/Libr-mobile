libr = angular.module 'libr.services', ['ngResource']

class BookService
  @$inject: ['$http']
  constructor: ($http)->
    baseUrl = 'http://libr.herokuapp.com/api/v1/books'
    bookFactory = {}
    bookFactory.getBook = (isbn) ->
      $http.get baseUrl + '/bookinfo/' + isbn
    return bookFactory

libr.factory 'BookService', BookService
