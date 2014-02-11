libr = angular.module 'libr.services', ['ngResource']

class BookService
  @$inject: ['$http']
  constructor: ($http)->
    baseUrl = 'http://libr.herokuapp.com/api'
    bookFactory = {}
    bookFactory.getBooks = () ->
      $http.get(baseUrl + '/books?user_email=wahyd4@qq.com&user_token=5w1snRq8QgxBfxayzTa2')
    bookFactory.getBook = (isbn) ->
      $http.get baseUrl + '/bookinfo/' + isbn
    return bookFactory

libr.factory 'BookService', BookService
