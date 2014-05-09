(function() {
  var Books, libr;

  libr = angular.module('libr.services.books', ['ngResource']);

  Books = (function() {
    Books.$inject = ['$http', '$resource', 'Constant', 'LocalStorageUtils'];

    function Books($resource, Constant, LocalStorageUtils) {
      var url;
      this.$resource = $resource;
      this.Constant = Constant;
      this.LocalStorageUtils = LocalStorageUtils;
      url = this.Constant.baseUrl + '/users/:user_id/books/:book_id';
      return this.$resource(url, {
        user_email: this.LocalStorageUtils.getUserEmail(),
        user_token: this.LocalStorageUtils.getUserToken(),
        user_id: this.LocalStorageUtils.getUserId(),
        book_id: '@bookId'
      }, {
        'get': {
          cache: true,
          method: 'GET'
        },
        'query': {
          method: 'GET',
          isArray: false,
          cache: false
        },
        'fetchNew': {
          method: 'GET',
          isArray: false,
          cache: true,
          url: this.Constant.baseUrl + '/books/newbooks/:afterId'
        }
      });
    }

    return Books;

  })();

  libr.factory('Books', ['$resource', 'Constant', 'LocalStorageUtils', Books]);

}).call(this);
