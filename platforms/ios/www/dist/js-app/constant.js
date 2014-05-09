(function() {
  var Constant, libr;

  libr = angular.module('libr.constant', []);

  Constant = {};

  Constant.baseUrl = "http://10.17.2.10:3000/api/v1";

  libr.constant('Constant', Constant);

}).call(this);
