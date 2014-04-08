libr = angular.module 'libr.services.auth', []

class AuthicationService
  @$inject: ['$http','Constant']
  constructor: (@$http,@Constant)->
    console.log 'init auth service'

  login: (user, callback, errorCallback)=>
    baseUrl = @Constant.baseUrl + '/sessions'
    @$http({
      method: 'POST',
      url: baseUrl,
      data: "user[email]=#{user.email}&user[password]=#{user.password}",
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
    })
    .success (result)->
      if result.success
        callback(result)
      else
        errorCallback '登录失败,请输入正确的用户名和密码'
    .error (data)->
      errorCallback '登录失败,请输入正确的用户名和密码'

  register: (user, callback, onError)=>
    url = @Constant.baseUrl + '/registrations'
    @$http({
      method: 'POST',
      url: url,
      data: "user[email]=#{user.email}&user[password]=#{user.password}",
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
    })
    .success (result, status)->
      callback(result, status)
    .error (data, status)->
      onError(data)


libr.service 'AuthService', AuthicationService
