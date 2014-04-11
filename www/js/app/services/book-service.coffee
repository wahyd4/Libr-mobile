libr = angular.module 'libr.services.books', ['ngResource']

class Books

  @$inject: ['$http', '$resource','Constant','LocalStorageUtils']
  constructor: (@$resource,@Constant,@LocalStorageUtils)->
    url = @Constant.baseUrl + '/users/:user_id/books/:book_id'
    return @$resource(url, {
        user_email: localStorage.getItem 'email'
        user_token: localStorage.getItem 'token'
        user_id: @LocalStorageUtils.getUserId()
        book_id: '@bookId'
      },
      {
        'query':
          method: 'GET'
          isArray: false
          cache: true
        'fetchNew':
          method: 'GET'
          isArray: false
          cache: true
          url: @Constant.baseUrl + '/books/newbooks/:afterId'
      })

libr.factory 'Books', ['$resource','Constant','LocalStorageUtils', Books]
