libr = angular.module 'libr.services.comment', ['ngResource']

class CommentService

  @$inject: ['$http', '$resource', 'Constant']
  constructor: (@$resource, @Constant)->
    baseUrl = @Constant.baseUrl + '/books/:book_id/comments/:comment_id'
    return @$resource(baseUrl, {
        user_email: localStorage.getItem 'email'
        user_token: localStorage.getItem 'token'
        book_id: '@bookId'
        comment_id: '@commentId'
      },
      {
        'query':
          method: 'GET'
          isArray: true
          cache: false
      }, {
        'save':
          params:
            comment_id: '@commentId'
      })

libr.factory 'Comments', ['$resource', 'Constant', CommentService]
