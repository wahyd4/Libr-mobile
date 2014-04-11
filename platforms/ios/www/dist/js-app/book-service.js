(function() {
  var Books, libr;

  libr = angular.module('libr.services.books', ['ngResource']);

  Books = (function() {
    Books.$inject = ['$http', '$resource', 'Constant'];

    function Books($resource, Constant) {
      var url;
      this.$resource = $resource;
      this.Constant = Constant;
      url = this.Constant.baseUrl + '/books/:book_id';
      return this.$resource(url, {
        user_email: localStorage.getItem('email'),
        user_token: localStorage.getItem('token')
      }, {
        'query': {
          method: 'GET',
          isArray: false,
          cache: false
        },
        'fetchNew': {
          method: 'GET',
          isArray: false,
          cache: false,
          url: this.Constant.baseUrl + '/books/newbooks/:afterId'
        }
      });
    }

    return Books;

  })();

  libr.factory('Books', ['$resource', 'Constant', Books]);

}).call(this);
