libr = angular.module 'libr.services.books', ['ngResource']

class Books

  @$inject: ['$http', '$resource', 'Constant', 'LocalStorageUtils']
  constructor: (@$resource, @Constant, @LocalStorageUtils)->
    url = @Constant.baseUrl + '/users/:user_id/books/:book_id'
    return @$resource(url, {
        user_email: @LocalStorageUtils.getUserEmail()
        user_token: @LocalStorageUtils.getUserToken()
        user_id: @LocalStorageUtils.getUserId()
        book_id: '@bookId'
      },
      {
        'get':
          cache: true
          method: 'GET'
        'query':
          method: 'GET'
          isArray: false
          cache: false
        'fetchNew':
          method: 'GET'
          isArray: false
          cache: true
          url: @Constant.baseUrl + '/books/newbooks/:afterId'
      })

libr.factory 'Books', ['$resource', 'Constant', 'LocalStorageUtils', Books]
