libr = angular.module 'libr.controllers.books', []

class BooksController

  @$inject: ['$scope']
  constructor: (@$scope)->
    unless localStorage.token and localStorage.email
      console.log '请先登录'
    else
      console.log '已经登录'

libr.controller 'BooksController', BooksController