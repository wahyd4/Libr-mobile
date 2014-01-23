angular.module('starter.controllers', [])


// A simple controller that fetches a list of data from a service
.controller('PetIndexCtrl', function($scope, BookService) {
        // "Pets" is a service returning mock data (services.js)
        BookService.getBooks().success(function(result){
            $scope.books = result.books;
        });
})


// A simple controller that shows a tapped item's data
.controller('PetDetailCtrl', function($scope, $stateParams, BookService) {
  // "Pets" is a service returning mock data (services.js)
          BookService.getBook($stateParams.isbn)
            .success(function (result){
                  $scope.book = result
            });
});
