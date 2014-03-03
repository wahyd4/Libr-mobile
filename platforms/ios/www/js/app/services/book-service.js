// Generated by CoffeeScript 1.7.1
(function() {
  var Books, libr;

  libr = angular.module('libr.services.books', ['ngResource']);

  Books = (function() {
    Books.$inject = ['$http', '$resource'];

    function Books($resource) {
      var baseUrl;
      this.$resource = $resource;
      baseUrl = 'http://libr.herokuapp.com/api/v1/books/:book_id';
      return this.$resource(baseUrl, {
        user_email: localStorage.getItem('email'),
        user_token: localStorage.getItem('token')
      }, {
        'query': {
          method: 'GET',
          isArray: false
        },
        'fetchNew': {
          method: 'GET',
          isArray: false,
          url: 'http://libr.herokuapp.com/api/v1/books/newbooks/:afterId'
        }
      });
    }

    return Books;

  })();

  libr.factory('Books', ['$resource', Books]);

}).call(this);
