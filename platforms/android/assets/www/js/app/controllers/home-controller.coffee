libr = angular.module 'libr.controllers.home', ['ionic']

class HomeController
  @$inject: ['$scope', '$location', 'ScanService', '$ionicLoading', '$ionicActionSheet',
             'RecommendService', 'ErrorHandler', 'LocalStorageUtils']
  constructor: (@$scope, @$location, ScanService, @$ionicLoading, @$ionicActionSheet, @RecommendService, @ErrorHandler, @LocalStorageUtils)->
    console.log @$scope, '!!!!!!!'
    @$scope.showRecommendActionSheet = @showRecommendActionSheet
    if @LocalStorageUtils.isUserLogedIn()
      showLoading(@$scope, @$ionicLoading)
      @$scope.title = {'name': 'Libr-随便看看吧'}
      if localStorage.getItem('home.books') is null
        @RecommendService.randomBooks (result)=>
          @$scope.books = result
          localStorage.setItem 'home.books', JSON.stringify(result)
          @$ionicLoading.hide()
        , (error)=>
          @ErrorHandler.loadingHandler @$scope, null
      else
        @$scope.books = JSON.parse(localStorage.getItem('home.books'))
        @$ionicLoading.hide()

    else
      @$location.path '/tab/settings'
      return
    @$scope.changeRecommend = @changeRecommend

  showLoading = ($scope, $ionicLoading)->
    $scope.loading = $ionicLoading.show {
      content: '加载中',
      animation: 'fade-in',
      showBackdrop: true,
      maxWidth: 200,
      showDelay: 500
    }

  showRecommendActionSheet: =>
    @$ionicActionSheet.show {
      titleText: 'Libr 为你推荐'
      buttons: @RecommendService.getActionSheetList()
      cancelText: '取消'
      cancel: ()->
        console.log('CANCELLED')
      buttonClicked: (index)=>
        console.log "#{index} has been taped"
        @changeRecommend index
        true

    }
  changeRecommend: (index)=>
    msg = '喔，看来附近还没有好书推荐，快去推荐你的朋友也来使用吧！'
    @RecommendService.changeRecommendAction index, (result)=>
      if result.length is 0
        navigator.notification.alert(msg, null, 'libr', '确定')
      else
        @$scope.books = result
        localStorage.setItem 'home.books', JSON.stringify(result)
        listArray = JSON.parse(localStorage.getItem 'recommend_action_sheet_full_arr')
        @$scope.title.name = listArray[index].text

        console.log @$scope, '========'
    , (error)=>
      @ErrorHandler.whenError null
libr.controller 'HomeCtrl', HomeController
