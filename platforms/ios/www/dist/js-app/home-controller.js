(function() {
  var HomeController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.home', ['ionic']);

  HomeController = (function() {
    var isUserLogedIn, showLoading;

    HomeController.$inject = ['$scope', '$location', 'ScanService', '$ionicLoading', '$ionicActionSheet', 'RecommendService', 'ErrorHandler'];

    function HomeController($scope, $location, ScanService, $ionicLoading, $ionicActionSheet, RecommendService, ErrorHandler) {
      this.$scope = $scope;
      this.$location = $location;
      this.$ionicLoading = $ionicLoading;
      this.$ionicActionSheet = $ionicActionSheet;
      this.RecommendService = RecommendService;
      this.ErrorHandler = ErrorHandler;
      this.changeRecommend = __bind(this.changeRecommend, this);
      this.showRecommendActionSheet = __bind(this.showRecommendActionSheet, this);
      this.$scope.showRecommendActionSheet = this.showRecommendActionSheet;
      if (isUserLogedIn()) {
        showLoading(this.$scope, this.$ionicLoading);
        this.$scope.title = '你可能喜欢的书';
        this.RecommendService.popularBooksForMe((function(_this) {
          return function(result) {
            if (result.length === 0) {
              alert('请先添加一些你阅读的书，再来查看推荐吧');
            } else {
              _this.$scope.books = result;
            }
            return _this.$scope.loading.hide();
          };
        })(this), (function(_this) {
          return function(error) {
            return _this.ErrorHandler.loadingHandler(_this.$scope, null);
          };
        })(this));
      } else {
        this.$location.path('/tab/settings');
        return;
      }
    }

    showLoading = function($scope, $ionicLoading) {
      return $scope.loading = $ionicLoading.show({
        content: '加载中',
        animation: 'fade-in',
        showBackdrop: true,
        maxWidth: 200,
        showDelay: 500
      });
    };

    isUserLogedIn = function() {
      if (localStorage.getItem('token') !== null && localStorage.getItem('email') !== null) {
        return true;
      } else {
        return false;
      }
    };

    HomeController.prototype.showRecommendActionSheet = function() {
      return this.$ionicActionSheet.show({
        titleText: 'Libr 为你推荐',
        buttons: this.RecommendService.getActionSheetList(),
        cancelText: '取消',
        cancel: function() {
          return console.log('CANCELLED');
        },
        buttonClicked: (function(_this) {
          return function(index) {
            console.log("" + index + " has been taped");
            _this.changeRecommend(index);
            return true;
          };
        })(this)
      });
    };

    HomeController.prototype.changeRecommend = function(index) {
      var msg;
      msg = '喔，看来附近还没有好书推荐，快去推荐你的朋友也来使用吧！';
      return this.RecommendService.changeRecommendAction(index, (function(_this) {
        return function(result) {
          var listArray;
          if (result.length === 0) {
            return navigator.notification.alert(msg, null, 'libr', '确定');
          } else {
            _this.$scope.books = result;
            listArray = JSON.parse(localStorage.getItem('recommend_action_sheet_full_arr'));
            return _this.$scope.title = listArray[index].text;
          }
        };
      })(this), (function(_this) {
        return function(error) {
          return _this.ErrorHandler.whenError(null);
        };
      })(this));
    };

    return HomeController;

  })();

  libr.controller('HomeCtrl', HomeController);

}).call(this);