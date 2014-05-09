(function() {
  var SettingsController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.settings', ['ionic']);

  SettingsController = (function() {
    var isUserLogedIn;

    SettingsController.$inject = ['$scope', '$ionicModal', 'AuthService', '$state', '$cacheFactory', 'LocalStorageUtils'];

    function SettingsController($scope, $ionicModal, AuthService, $state, $cacheFactory, LocalStorageUtils) {
      this.$scope = $scope;
      this.$ionicModal = $ionicModal;
      this.AuthService = AuthService;
      this.$state = $state;
      this.$cacheFactory = $cacheFactory;
      this.LocalStorageUtils = LocalStorageUtils;
      this.logout = __bind(this.logout, this);
      this.$scope.logout = this.logout;
      this.$scope.feedback = this.feedback;
      this.$scope.showMe = this.showMe;
      if (isUserLogedIn(this.LocalStorageUtils)) {
        this.$scope.isLogedIn = true;
      } else {
        this.$scope.isLogedIn = false;
      }
      this.$scope.avatar = this.LocalStorageUtils.getUserAvatar();
      this.$scope.username = this.LocalStorageUtils.getUserName();
    }

    SettingsController.prototype.logout = function() {
      var httpDefaultCache;
      localStorage.clear();
      httpDefaultCache = this.$cacheFactory.get('$http');
      console.log('cacheFactory', httpDefaultCache);
      httpDefaultCache.removeAll();
      return this.$state.go('login');
    };

    SettingsController.prototype.feedback = function() {
      return window.open('https://jinshuju.net/f/F96z3s', '_blank', 'location=no');
    };

    SettingsController.prototype.showMe = function() {
      return window.open('http://librme.com', '_blank', 'location=no');
    };

    isUserLogedIn = function(localStorageUtils) {
      if (localStorageUtils.getUserToken() !== null && localStorageUtils.getUserEmail() !== null) {
        return true;
      } else {
        return false;
      }
    };

    return SettingsController;

  })();

  libr.controller('SettingsController', SettingsController);

}).call(this);
