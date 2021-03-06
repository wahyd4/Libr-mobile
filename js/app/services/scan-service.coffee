libr = angular.module 'libr.services.scan', []

class ScanService

  @$inject: ['Books']
  constructor: (@Books)->

  scan: (callback, errorCallback)->
    navigator.notification.vibrate 50
    cordova.plugins.barcodeScanner.scan (result)=>
      console.log 'got scan result', result
      if result.cancelled is 1 then return
      if result.format isnt 'EAN_13'
        console.log '条码不匹配'
        errorCallback '条形码类型错误，请确认所扫为书籍，并更换角度'
        return
      @Books.save {isbn: result.text}, null, (data)->
        console.log 'get server response'
        if data.status is 'error'
          errorCallback data.message
        else
          callback(data)
      , (error)->
        errorCallback '添加图书失败' + error.data.message
    , (error)->
      errorCallback "扫描图书失败:#{error} "


libr.service 'ScanService', ScanService