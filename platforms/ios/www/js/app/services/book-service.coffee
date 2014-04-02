libr = angular.module 'libr.services.books', ['ngResource']

class Books

  @$inject: ['$http', '$resource','Constant']
  constructor: (@$resource,@Constant)->
    url = @Constant.baseUrl + '/books/:book_id'
    return @$resource(url, {
        user_email: localStorage.getItem 'email'
        user_token: localStorage.getItem 'token'
      },
      {
        'query':
          method: 'GET'
          isArray: false
          cache: false
        'fetchNew':
          method: 'GET'
          isArray: false
          cache: false
          url: @Constant.baseUrl + '/books/newbooks/:afterId'
      })

libr.factory 'Books', ['$resource','Constant', Books]
