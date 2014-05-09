(function() {
  var LoginController, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.controllers.login', ['ionic']);

  LoginController = (function() {
    LoginController.$inject = ['$scope', 'AuthService', '$state', '$ionicModal', 'IonicUtils', 'LocalStorageUtils'];

    function LoginController($scope, AuthService, $state, $ionicModal, IonicUtils, LocalStorageUtils) {
      this.$scope = $scope;
      this.AuthService = AuthService;
      this.$state = $state;
      this.$ionicModal = $ionicModal;
      this.IonicUtils = IonicUtils;
      this.LocalStorageUtils = LocalStorageUtils;
      this.closeDialog = __bind(this.closeDialog, this);
      this.registerUser = __bind(this.registerUser, this);
      this.registerForm = __bind(this.registerForm, this);
      this.login = __bind(this.login, this);
      if (this.LocalStorageUtils.isUserLogedIn()) {
        this.$state.go('tab.home');
      }
      this.$scope.login = this.login;
      this.$scope.registerForm = this.registerForm;
      this.$scope.registerUser = this.registerUser;
      this.$scope.closeDialog = this.closeDialog;
      this.$ionicModal.fromTemplateUrl('templates/modal/registration.html', (function(_this) {
        return function(modal) {
          return _this.$scope.modal = modal;
        };
      })(this), {
        scope: this.$scope,
        animation: 'slide-in-up'
      });
      this.IonicUtils.initCustomLoading(this.$scope);
    }

    LoginController.prototype.login = function(user) {
      if (!user || user.email === '' || user.password === '' || user.email === void 0 || user.password === void 0) {
        this.IonicUtils.showLoading(this.$scope, '请输入有效的用户名和密码');
        return;
      }
      return this.AuthService.login(user, (function(_this) {
        return function(result) {
          localStorage.setItem('token', result.user.token);
          localStorage.setItem('avatar', result.user.avatar);
          localStorage.setItem('username', result.user.name);
          localStorage.setItem('email', user.email);
          localStorage.setItem('user', JSON.stringify(result.user));
          return _this.$state.go('tab.home');
        };
      })(this), (function(_this) {
        return function(data) {
          return _this.IonicUtils.showLoading(_this.$scope, data);
        };
      })(this));
    };

    LoginController.prototype.registerForm = function() {
      return this.$scope.modal.show();
    };

    LoginController.prototype.registerUser = function(user) {
      if (!user || user.email === '' || user.password === '' || user.email === void 0 || user.password === void 0) {
        this.IonicUtils.showLoading(this.$scope, '请输入有效的用户名和密码');
      } else {
        return this.AuthService.register(user, (function(_this) {
          return function(result, status) {
            if (status === 201) {
              alert('注册成功，请返回登录');
              return _this.$scope.modal.hide();
            } else {
              return _this.IonicUtils.showLoading(_this.$scope, '注册失败,请确认是否输入正确，并重试');
            }
          };
        })(this), (function(_this) {
          return function(error) {
            _this.IonicUtils.showLoading(_this.$scope, '注册失败,请确认是否输入正确，并重试');
            return console.log("registerError", error);
          };
        })(this));
      }
    };

    LoginController.prototype.closeDialog = function() {
      return this.$scope.modal.hide();
    };

    return LoginController;

  })();

  libr.controller('LoginController', LoginController);

}).call(this);
