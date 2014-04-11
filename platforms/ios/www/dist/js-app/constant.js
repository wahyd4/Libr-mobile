(function() {
  var Constant, libr;

  libr = angular.module('libr.constant', []);

  Constant = {};

  Constant.baseUrl = "http://libr.herokuapp.com/api/v1";

  libr.constant('Constant', Constant);

}).call(this);
