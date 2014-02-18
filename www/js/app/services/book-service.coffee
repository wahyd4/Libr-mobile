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
        'update':
          method: 'PUT'
        'query':
          method: 'GET'
          isArray: false
      })

libr.factory 'Books', ['$resource', Books]
