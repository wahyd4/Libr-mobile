(function() {
  var ScanService, libr;

  libr = angular.module('libr.services.scan', []);

  ScanService = (function() {
    ScanService.$inject = ['Books'];

    function ScanService(Books) {
      this.Books = Books;
    }

    ScanService.prototype.scan = function(callback, errorCallback) {
      setTimeout((function(_this) {
        return function() {
          return cordova.plugins.barcodeScanner.scan(function(result) {
            console.log('got scan result', result);
            if (result.cancelled === 1) {
              return;
            }
            if (result.format !== 'EAN_13') {
              console.log('条码不匹配');
              errorCallback('条形码类型错误，请确认所扫为书籍，并更换角度');
              return;
            }
            return _this.Books.save({
              isbn: result.text
            }, null, function(data) {
              console.log('get server response');
              if (data.status === 'error') {
                return errorCallback(data.message);
              } else {
                return callback(data);
              }
            }, function(error) {
              return errorCallback('添加图书失败' + error.data.message);
            });
          }, function(error) {
            return errorCallback("扫描图书失败:" + error + " ");
          });
        };
      })(this), 600);
      return navigator.notification.vibrate(50);
    };

    return ScanService;

  })();

  libr.service('ScanService', ScanService);

}).call(this);
