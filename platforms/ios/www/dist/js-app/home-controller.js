(function() {
  var HomeController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.home', ['ionic']);

  HomeController = (function() {
    var showLoading;

    HomeController.$inject = ['$scope', '$location', 'ScanService', '$ionicLoading', '$ionicActionSheet', 'RecommendService', 'ErrorHandler', 'LocalStorageUtils'];

    function HomeController($scope, $location, ScanService, $ionicLoading, $ionicActionSheet, RecommendService, ErrorHandler, LocalStorageUtils) {
      this.$scope = $scope;
      this.$location = $location;
      this.$ionicLoading = $ionicLoading;
      this.$ionicActionSheet = $ionicActionSheet;
      this.RecommendService = RecommendService;
      this.ErrorHandler = ErrorHandler;
      this.LocalStorageUtils = LocalStorageUtils;
      this.changeRecommend = __bind(this.changeRecommend, this);
      this.showRecommendActionSheet = __bind(this.showRecommendActionSheet, this);
      this.$scope.showRecommendActionSheet = this.showRecommendActionSheet;
      if (this.LocalStorageUtils.isUserLogedIn()) {
        showLoading(this.$scope, this.$ionicLoading);
        this.$scope.title = '随便看看吧';
        this.RecommendService.randomBooks((function(_this) {
          return function(result) {
            _this.$scope.books = result;
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
