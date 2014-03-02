libr = angular.module 'libr.controllers.home', ['ionic']

class HomeController
  @$inject: ['$scope', '$location', 'BookService', 'ScanService', '$ionicLoading', '$ionicActionSheet',
             'RecommendService']
  constructor: (@$scope, @$location, BookService, ScanService, @$ionicLoading, @$ionicActionSheet, @RecommendService)->
    if isUserLogedIn()
      showLoading(@$scope, @$ionicLoading)
      BookService.getBooks().success (result)=>
        @$scope.books = result.books
        @$scope.enableBackButton = false
        @$scope.rightButtons = [
          {
            type: 'button  icon ion-shuffle'
            tap: (e) =>
              @showRecommendActionSheet()
          }
        ]
        @$scope.loading.hide();
    else
      @$location.path '/tab/settings'
      return

  showLoading = ($scope, $ionicLoading)->
    $scope.loading = $ionicLoading.show {
      content: '加载中',
      animation: 'fade-in',
      showBackdrop: true,
      maxWidth: 200,
      showDelay: 500
    }
  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false
  showRecommendActionSheet: =>
    @$ionicActionSheet.show {
      titleText: '推荐'
      buttons: @RecommendService.getActionSheetList()
      destructiveText: '删除'
      cancelText: '取消'
      cancel: ()->
        console.log('CANCELLED')
      buttonClicked: (index)->
        console.log('BUTTON CLICKED', index)
        true
      destructiveButtonClicked: ()->
        console.log('DESTRUCT')
        true
    }
libr.controller 'HomeCtrl', HomeController