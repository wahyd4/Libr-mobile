// Generated by CoffeeScript 1.6.3
(function() {
  var HomeController, libr;

  libr = angular.module('libr.controllers.home', ['ionic']);

  HomeController = (function() {
    var isUserLogedIn, showLoading;

    HomeController.$inject = ['$scope', '$location', 'BookService', 'ScanService', '$ionicLoading'];

    function HomeController($scope, $location, BookService, ScanService, $ionicLoading) {
      var _this = this;
      this.$scope = $scope;
      this.$location = $location;
      this.$ionicLoading = $ionicLoading;
      if (isUserLogedIn()) {
        showLoading(this.$scope, this.$ionicLoading);
        BookService.getBooks().success(function(result) {
          _this.$scope.books = result.books;
          _this.$scope.enableBackButton = false;
          _this.$scope.rightButtons = [
            {
              type: 'button-icon icon ion-camera',
              tap: function(e) {
                return ScanService.scan();
              }
            }
          ];
          return _this.$scope.loading.hide();
        });
      } else {
        console.log('ssssssssssssss');
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

    return HomeController;

  })();

  libr.controller('HomeCtrl', HomeController);

}).call(this);