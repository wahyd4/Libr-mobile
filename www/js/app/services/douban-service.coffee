libr = angular.module 'libr.services.douban', []


class DoubanService

  @$inject: ['$http', 'Constant', 'LocalStorageUtils']
  constructor: (@$http, @Constant, @LocalStorageUtils)->


  userInfo: (user, callback, error)->
    @$http(
      url: "http://api.douban.com/v2/user/#{user}"
      method: 'GET'
      timeout: 10000
      cache: true
    )
    .success (data, status, headers, config)->
      if status is 200
        callback data
      else
        error data
    .error (data)->
      error data

  bookDetail: (isbn, callback, error)->
    @$http(
      url: "https://api.douban.com/v2/book/isbn/#{isbn}"
      method: 'GET'
      timeout: 10000
      cache: true
    )
    .success (data, status, headers, config)->
      if status is 200
        callback data
      else
        error data
    .error (data)->
      error data

  submitUser: (user, callback, error)=>
    email = localStorage.getItem 'email'
    token = localStorage.getItem 'token'
    userId = @LocalStorageUtils.getUserId()
    @$http({
      url: "#{@Constant.baseUrl}/users/#{userId}/link/douban/#{user}?user_email=#{email}&user_token=#{token}"
      method: 'POST'
      timeout: 10000
    })
    .success (data, status, headers, config)->
      callback data
    .error (data)->
      error data


libr.service 'DoubanService', DoubanService
