libr = angular.module 'libr.services.douban', []


class DoubanService

  @$inject: ['$http']
  constructor: (@$http)->


  userInfo: (user, callback, error)->
    @$http(
      url: "http://api.douban.com/v2/user/#{user}"
      method: 'GET'
      timeout: 10000
    )
    .success (data, status, headers, config)->
      if status is 200
        callback data
      else
        error data
    .error (data)->
      error data

libr.service 'DoubanService', DoubanService

