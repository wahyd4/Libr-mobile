libr = angular.module 'libr.services.scan', []

class ScanService

  @$inject: ['Books']
  constructor: (@Books)->

  scan: (callback)->
    setTimeout () =>
      cordova.plugins.barcodeScanner.scan (result)=>
        @Books.save {isbn: result.text}, null, (data)->
          if data.status is 'error'
            alert '不能找到该书'
          else
            callback(data)
        , (error)->
          alert '添加图书失败'
      , (error)->
        alert "Scanning failed:#{error} "
    , 700

  save: ->
    @Books.save {isbn: '9787550221116'}, null, (result)->
      if result.status is 'error'
        alert '不能找到该书'
      else
        alert '添加图书成功'


libr.service 'ScanService', ScanService