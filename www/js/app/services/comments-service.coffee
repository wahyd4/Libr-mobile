libr = angular.module 'libr.services.comment', ['ngResource']

class CommentService

  @$inject: ['$http', '$resource']
  constructor: (@$resource)->
    baseUrl = 'http://libr.herokuapp.com/api/v1/books/:book_id/comments/:comment_id'
    return @$resource(baseUrl, {
        user_email: localStorage.getItem 'email'
        user_token: localStorage.getItem 'token'
        book_id: '@bookId'
        comment_id: '@commentId'
      },
      {
        'query':
          method: 'GET'
          isArray: false
          cache: false
      })

libr.factory 'Comments', ['$resource', CommentService]


