// Generated by CoffeeScript 1.7.1
(function() {
  var SettingsController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.settings', ['ionic']);

  SettingsController = (function() {
    var isUserLogedIn;

    SettingsController.$inject = ['$scope', '$ionicModal', 'AuthService', '$state'];

    function SettingsController($scope, $ionicModal, AuthService, $state) {
      this.$scope = $scope;
      this.$ionicModal = $ionicModal;
      this.AuthService = AuthService;
      this.$state = $state;
      this.login = __bind(this.login, this);
      this.$scope.login = this.login;
      this.$scope.logout = this.logout;
      if (isUserLogedIn()) {
        this.$scope.isLogedIn = true;
      } else {
        this.$scope.isLogedIn = false;
      }
    }

    SettingsController.prototype.login = function(user) {
      console.log(user);
      return this.AuthService.login(user, (function(_this) {
        return function(result) {
          localStorage.setItem('token', result.token);
          localStorage.setItem('email', user.email);
          return _this.closeModal();
        };
      })(this));
    };

    SettingsController.prototype.logout = function() {
      localStorage.removeItem('email');
      localStorage.removeItem('token');
      return this.$state.go('login');
    };

    isUserLogedIn = function() {
      if (localStorage.getItem('token') !== null && localStorage.getItem('email') !== null) {
        return true;
      } else {
        return false;
      }
    };

    return SettingsController;

  })();

  libr.controller('SettingsController', SettingsController);

}).call(this);
