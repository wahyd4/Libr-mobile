(function() {
  var AuthicationService, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.services.auth', []);

  AuthicationService = (function() {
    AuthicationService.$inject = ['$http', 'Constant'];

    function AuthicationService($http, Constant) {
      this.$http = $http;
      this.Constant = Constant;
      this.register = __bind(this.register, this);
      this.login = __bind(this.login, this);
      console.log('init auth service');
    }

    AuthicationService.prototype.login = function(user, callback, errorCallback) {
      var baseUrl;
      baseUrl = this.Constant.baseUrl + '/sessions';
      return this.$http({
        method: 'POST',
        url: baseUrl,
        data: "user[email]=" + user.email + "&user[password]=" + user.password,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }).success(function(result) {
        if (result.success) {
          return callback(result);
        } else {
          return errorCallback('登录失败,请输入正确的用户名和密码');
        }
      }).error(function(data) {
        return errorCallback('登录失败,请输入正确的用户名和密码');
      });
    };

    AuthicationService.prototype.register = function(user, callback, onError) {
      var url;
      url = this.Constant.baseUrl + '/registrations';
      return this.$http({
        method: 'POST',
        url: url,
        data: "user[email]=" + user.email + "&user[password]=" + user.password,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }).success(function(result, status) {
        return callback(result, status);
      }).error(function(data, status) {
        return onError(data);
      });
    };

    return AuthicationService;

  })();

  libr.service('AuthService', AuthicationService);

}).call(this);
