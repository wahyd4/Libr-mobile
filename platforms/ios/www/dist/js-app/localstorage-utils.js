(function() {
  var LocalStorageUtils, libr;

  libr = angular.module('libr.services.localstorage', []);

  LocalStorageUtils = (function() {
    function LocalStorageUtils() {}

    LocalStorageUtils.prototype.getUser = function() {
      return JSON.parse(localStorage.getItem('user'));
    };

    LocalStorageUtils.prototype.getUserId = function() {
      var user;
      user = this.getUser();
      return user.id;
    };

    LocalStorageUtils.prototype.getUserName = function() {
      var user;
      user = this.getUser();
      return user.name;
    };

    LocalStorageUtils.prototype.getUserToken = function() {
      var user;
      user = this.getUser();
      return user.token;
    };

    LocalStorageUtils.prototype.getUserAvatar = function() {
      var user;
      user = this.getUser();
      return user.avatar;
    };

    LocalStorageUtils.prototype.getUserEmail = function() {
      var user;
      user = this.getUser();
      return user.email;
    };

    LocalStorageUtils.prototype.isUserLogedIn = function() {
      var user;
      user = this.getUser();
      return user !== null && this.getUserEmail() !== null && this.getUserToken() !== null;
    };

    LocalStorageUtils.prototype.storeDoubanUser = function(name) {
      return localStorage.setItem('doubanUser', name);
    };

    LocalStorageUtils.prototype.getDoubanUser = function() {
      var user;
      user = this.getUser();
      if (user.douban_user !== null) {
        return user.douban_user;
      } else if (localStorage.getItem('doubanUser') !== null) {
        return localStorage.getItem('doubanUser');
      } else {
        return null;
      }
    };

    return LocalStorageUtils;

  })();

  libr.service('LocalStorageUtils', LocalStorageUtils);

}).call(this);
