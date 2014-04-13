(function() {
  var MainController, libr;

  libr = angular.module('libr.controllers.main', ['ionic']);

  MainController = (function() {
    MainController.$inject = ['$scope', '$location', '$ionicModal', '$state'];

    function MainController($scope, $location, $ionicModal, $state) {
      this.$scope = $scope;
      this.$location = $location;
      this.$ionicModal = $ionicModal;
      this.$state = $state;
    }

    return MainController;

  })();

  libr.controller('MainCtrl', MainController);

}).call(this);