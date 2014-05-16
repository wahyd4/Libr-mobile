libr = angular.module 'libr.handlers.errorHandler', []

class ErrorHandler


  loadingHandler: ($scope, callback)->
    $scope.loading.hide()
    message = '加载失败，请确认有良好网络连接，并重试'
    navigator.notification.confirm message, ()=>
      callback()
    , '加载失败', ['确定', '取消']

  whenError: (callback)->
    message = '加载失败，请确认有良好网络连接，并重试'
    navigator.notification.confirm message, ()=>
      callback()
    , '加载失败', ['确定', '取消']

libr.service 'ErrorHandler', ErrorHandler