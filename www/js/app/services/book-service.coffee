libr = angular.module 'libr.services.books', ['ngResource']

class Books
  @$inject: ['$http', '$resource']
  constructor: (@$resource)->
    baseUrl = 'http://libr.herokuapp.com/api/v1/books/:book_id'
    return @$resource(baseUrl, {
        user_email: localStorage.getItem 'email'
        user_token: localStorage.getItem 'token'
      },
      {
        'query':
          method: 'GET'
          isArray: false
        'fetchNew':
          method: 'GET'
          isArray: false
          url: 'http://libr.herokuapp.com/api/v1/books/newbooks/:afterId'
      })

libr.factory 'Books', ['$resource', Books]
