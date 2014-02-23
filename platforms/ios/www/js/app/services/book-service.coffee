libr = angular.module 'libr.services.books', ['ngResource']

class Books
  email = localStorage.getItem 'email'
  token = localStorage.getItem 'token'

  @$inject: ['$http', '$resource']
  constructor: (@$resource)->
    baseUrl = 'http://libr.herokuapp.com/api/v1/books/:book_id'

    return @$resource(baseUrl, {
        user_email: email
        user_token: token
      },
      {
        'query':
          method: 'GET'
          isArray: false
          cache: true
        'fetchNew':
          method: 'GET'
          isArray: false
          url: 'http://libr.herokuapp.com/api/v1/books/newbooks/:afterId'
      })

libr.factory 'Books', ['$resource', Books]
