libr = angular.module 'libr.services.scan', []

class ScanService

  scan: =>
    alert '即将使用摄像头获取ISBN编号'
    cordova.plugins.barcodeScanner.scan (result)->
      alert "We got a barcode\n Result: #{result.text} \n Format: #{result.format} \n Cancelled: #{result.cancelled}"
      , (error)->
        alert "Scanning failed:#{error} "
libr.service 'ScanService', ScanService