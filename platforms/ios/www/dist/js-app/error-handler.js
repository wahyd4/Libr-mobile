(function() {
  var ErrorHandler, libr;

  libr = angular.module('libr.handlers.errorHandler', []);

  ErrorHandler = (function() {
    function ErrorHandler() {}

    ErrorHandler.prototype.loadingHandler = function($scope, callback) {
      var message;
      $scope.loading.hide();
      message = '加载失败，请确认有良好网络连接，并重试';
      return navigator.notification.confirm(message, (function(_this) {
        return function() {
          return callback();
        };
      })(this), '加载失败', ['确定', '取消']);
    };

    ErrorHandler.prototype.whenError = function(callback) {
      var message;
      message = '加载失败，请确认有良好网络连接，并重试';
      return navigator.notification.confirm(message, (function(_this) {
        return function() {
          return callback();
        };
      })(this), '加载失败', ['确定', '取消']);
    };

    return ErrorHandler;

  })();

  libr.service('ErrorHandler', ErrorHandler);

}).call(this);
