(function() {
  var BooksController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.books', ['ionic']);

  BooksController = (function() {
    BooksController.$inject = ['$scope', 'Books', 'ScanService', '$ionicModal', 'DoubanService', 'IonicUtils'];

    function BooksController($scope, Books, ScanService, $ionicModal, DoubanService, IonicUtils) {
      var currentPage;
      this.$scope = $scope;
      this.Books = Books;
      this.ScanService = ScanService;
      this.$ionicModal = $ionicModal;
      this.DoubanService = DoubanService;
      this.IonicUtils = IonicUtils;
      this.submitDoubanUser = __bind(this.submitDoubanUser, this);
      this.scanBooks = __bind(this.scanBooks, this);
      this.searchDoubanUser = __bind(this.searchDoubanUser, this);
      this.closeDialog = __bind(this.closeDialog, this);
      this.loadMore = __bind(this.loadMore, this);
      this.refresh = __bind(this.refresh, this);
      currentPage = localStorage.setItem('user_books_current_page', 0);
      this.$scope.books = [];
      this.$scope.moreItemsAvailable = true;
      this.$scope.submitAllowed = true;
      this.$ionicModal.fromTemplateUrl('templates/modal/import_books.html', (function(_this) {
        return function(modal) {
          return _this.$scope.modal = modal;
        };
      })(this), {
        scope: this.$scope,
        animation: 'slide-in-up'
      });
      this.$scope.data = {
        isLoading: false,
        text: null
      };
      this.IonicUtils.initCustomLoading(this.$scope);
      this.$scope.onRefresh = this.refresh;
      this.$scope.loadMore = this.loadMore;
      this.$scope.closeDialog = this.closeDialog;
      this.$scope.searchDoubanUser = this.searchDoubanUser;
      this.$scope.scanBooks = this.scanBooks;
      this.$scope.submitDoubanUser = this.submitDoubanUser;
      this.$scope.doubanInputDisabled = false;
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

    BooksController.prototype.loadMore = function() {
      var currentPage, maxPage;
      currentPage = localStorage.getItem('user_books_current_page');
      maxPage = localStorage.getItem('user_books_max_page');
      maxPage = parseInt(maxPage);
      currentPage = parseInt(currentPage);
      if (!(currentPage >= maxPage)) {
        return this.Books.query({
          page: currentPage + 1
        }, (function(_this) {
          return function(data) {
            if (data.books.length !== 0) {
              localStorage.setItem('user_max_book_id', data.books[0].id);
              localStorage.setItem('user_books_current_page', data.current_page);
              localStorage.setItem('user_books_max_page', data.total_page);
              data.books.forEach(function(item, index, array) {
                return _this.$scope.books.push(item);
              });
            } else {
              _this.$scope.moreItemsAvailable = false;
            }
            return _this.$scope.$broadcast('scroll.infiniteScrollComplete');
          };
        })(this));
      } else {
        this.$scope.$broadcast('scroll.infiniteScrollComplete');
        return this.$scope.moreItemsAvailable = false;
      }
    };

    BooksController.prototype.closeDialog = function() {
      return this.$scope.modal.hide();
    };

    BooksController.prototype.searchDoubanUser = function(user) {
      if (user === void 0 || user.trim() === '') {
        return this.IonicUtils.showLoading(this.$scope, '请输入有效昵称');
      } else {
        return this.DoubanService.userInfo(user, (function(_this) {
          return function(data) {
            _this.$scope.resultEnabled = true;
            _this.$scope.submitAllowed = true;
            return _this.$scope.doubanUser = data;
          };
        })(this), (function(_this) {
          return function(error) {
            console.log(error);
            _this.$scope.resultEnabled = false;
            return _this.$scope.submitAllowed = false;
          };
        })(this));
      }
    };

    BooksController.prototype.scanBooks = function() {
      return this.ScanService.scan((function(_this) {
        return function(result) {
          navigator.notification.alert("添加图书《" + result.book.name + "》成功", null, "Libr", "确定");
          return _this.$scope.books.unshift(result.book);
        };
      })(this), (function(_this) {
        return function(error) {
          return _this.IonicUtils.showLoading(_this.$scope, error);
        };
      })(this));
    };

    BooksController.prototype.submitDoubanUser = function() {
      var username;
      username = angular.element(document.getElementById('douban-username'));
      username = username.val();
      return this.DoubanService.submitUser(username, (function(_this) {
        return function(data) {
          _this.$scope.doubanInputDisabled = true;
          return alert('成功绑定豆瓣用户', function(data) {
            return _this.IonicUtils.showLoading(_this.$scope, '绑定豆瓣用户失败，请稍后再试');
          });
        };
      })(this));
    };

    return BooksController;

  })();

  libr.controller('BooksController', BooksController);

}).call(this);
