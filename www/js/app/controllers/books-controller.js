// Generated by CoffeeScript 1.7.1
(function() {
  var BooksController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.books', []);

  BooksController = (function() {
    BooksController.$inject = ['$scope', 'Books', 'ScanService', '$timeout'];

    function BooksController($scope, Books, ScanService) {
      this.$scope = $scope;
      this.Books = Books;
      this.loadMore = __bind(this.loadMore, this);
      this.refresh = __bind(this.refresh, this);
      this.Books.query({}, (function(_this) {
        return function(data) {
          localStorage.setItem('user_max_book_id', data.books[0].id);
          localStorage.setItem('user_min_book_id', data.books[data.books.length - 1].id);
          localStorage.setItem('user_books_current_page', data.current_page);
          return _this.$scope.books = data.books;
        };
      })(this));
      this.$scope.rightButtons = [
        {
          type: 'button  icon ion-camera',
          tap: (function(_this) {
            return function(e) {
              return ScanService.scan(function(result) {
                navigator.notification.alert("添加图书《" + result.book.name + "》成功", null, "Libr", "确定");
                return _this.$scope.books.unshift(result.book);
              });
            };
          })(this)
        }
      ];
      this.$scope.onRefresh = this.refresh;
      this.$scope.loadMore = this.loadMore;
    }

    BooksController.prototype.refresh = function() {
      var afterBookId;
      afterBookId = localStorage.getItem('user_max_book_id');
      return this.Books.fetchNew({
        afterId: afterBookId
      }, (function(_this) {
        return function(data) {
          _this.$scope.$broadcast('scroll.refreshComplete');
          if (data.books.length !== 0) {
            localStorage.setItem('user_max_book_id', data.books[0].id);
            return data.books.forEach(function(item, index, array) {
              return _this.$scope.books.push(item);
            });
          }
        };
      })(this));
    };

    BooksController.prototype.loadMore = function(done) {
      var currentPage;
      currentPage = localStorage.getItem('user_books_current_page');
      currentPage = parseInt(currentPage);
      return this.Books.query({
        page: currentPage + 1
      }, (function(_this) {
        return function(data) {
          if (data.books.length !== 0) {
            localStorage.setItem('user_books_current_page', data.current_page);
            data.books.forEach(function(item, index, array) {
              return _this.$scope.books.push(item);
            });
          }
          return done();
        };
      })(this));
    };

    return BooksController;

  })();

  libr.controller('BooksController', BooksController);

}).call(this);
