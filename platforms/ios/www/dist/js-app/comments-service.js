(function() {
  var CommentService, libr;

  libr = angular.module('libr.services.comment', ['ngResource']);

  CommentService = (function() {
    CommentService.$inject = ['$http', '$resource', 'Constant'];

    function CommentService($resource, Constant) {
      var baseUrl;
      this.$resource = $resource;
      this.Constant = Constant;
      baseUrl = this.Constant.baseUrl + '/books/:book_id/comments/:comment_id';
      return this.$resource(baseUrl, {
        user_email: localStorage.getItem('email'),
        user_token: localStorage.getItem('token'),
        book_id: '@bookId',
        comment_id: '@commentId'
      }, {
        'query': {
          method: 'GET',
          isArray: true,
          cache: false
        }
      }, {
        'save': {
          params: {
            comment_id: '@commentId'
          }
        }
      });
    }

    return CommentService;

  })();

  libr.factory('Comments', ['$resource', 'Constant', CommentService]);

}).call(this);
