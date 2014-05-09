(function() {
  var DoubanService, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.services.douban', []);

  DoubanService = (function() {
    DoubanService.$inject = ['$http', 'Constant', 'LocalStorageUtils'];

    function DoubanService($http, Constant, LocalStorageUtils) {
      this.$http = $http;
      this.Constant = Constant;
      this.LocalStorageUtils = LocalStorageUtils;
      this.submitUser = __bind(this.submitUser, this);
    }

    DoubanService.prototype.userInfo = function(user, callback, error) {
      return this.$http({
        url: "http://api.douban.com/v2/user/" + user,
        method: 'GET',
        timeout: 10000,
        cache: true
      }).success(function(data, status, headers, config) {
        if (status === 200) {
          return callback(data);
        } else {
          return error(data);
        }
      }).error(function(data) {
        return error(data);
      });
    };

    DoubanService.prototype.submitUser = function(user, callback, error) {
      var email, token, userId;
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      userId = this.LocalStorageUtils.getUserId();
      return this.$http({
        url: "" + this.Constant.baseUrl + "/users/" + userId + "/link/douban/" + user + "?user_email=" + email + "&user_token=" + token,
        method: 'POST',
        timeout: 10000
      }).success(function(data, status, headers, config) {
        return callback(data);
      }).error(function(data) {
        return error(data);
      });
    };

    return DoubanService;

  })();

  libr.service('DoubanService', DoubanService);

}).call(this);
