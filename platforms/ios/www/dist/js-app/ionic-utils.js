(function() {
  var IonicUtils, libr;

  libr = angular.module('libr.services.utils', []);

  IonicUtils = (function() {
    IonicUtils.$inject = ['$timeout'];

    function IonicUtils($timeout) {
      this.$timeout = $timeout;
    }

    IonicUtils.prototype.initCustomLoading = function(scope) {
      return scope.data = {
        isLoading: false,
        text: null
      };
    };

    IonicUtils.prototype.showLoading = function(scope, text, timing) {
      if (timing == null) {
        timing = 3000;
      }
      scope.data = {
        isLoading: true,
        text: text
      };
      return this.$timeout((function(_this) {
        return function() {
          return _this.initCustomLoading(scope);
        };
      })(this), timing);
    };

    IonicUtils.prototype.cacheImage = function() {};

    return IonicUtils;

  })();

  libr.service('IonicUtils', IonicUtils);

}).call(this);
