libr = angular.module('starter.controllers', [])


libr
.controller('MainCtrl', ['$scope', '$location', ($scope, $location)->
    $scope.goTo = (page)->
      $scope.sideMenuController.toggleRight()
      $location.url('/' + page)
])

.controller 'HomeCtrl', ($scope, BookService)->
    BookService.getBooks().success (result)->
      $scope.books = result.books
      $scope.enableBackButton = false;

      $scope.rightButtons = [{
        type: 'button-icon icon ion-navicon',
        tap: (e)-> $scope.sideMenuController.toggleRight()
      }]
      $scope.leftButtons = [{
        type: 'button-icon icon ion-camera'
        tap: (e) -> alert 'Hello'
      }]

.controller 'PetDetailCtrl', ($scope, $stateParams, BookService)->
    BookService.getBook($stateParams.isbn)
    .success (result) ->
        $scope.book = result
        $scope.enableBackButton = true;
        $scope.rightButtons = [{
          type: 'button-icon icon ion-navicon',
          tap: (e)-> $scope.sideMenuController.toggleRight()
        }]
        $scope.leftButtons = [];
        $scope.bookName = result.name