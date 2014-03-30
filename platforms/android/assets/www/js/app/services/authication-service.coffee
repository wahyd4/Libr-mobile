libr = angular.module 'libr.services.auth', []

class AuthicationService
  @$inject: ['$http']
  constructor: (@$http)->
    console.log 'init auth service'

  login: (user, callback)=>
    baseUrl = 'http://libr.herokuapp.com/api/v1/sessions'
    @$http({
      method: 'POST',
      url: baseUrl,
      data: "user[email]=#{user.email}&user[password]=#{user.password}",
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
    }).success (result)->
      if result.success
        callback(result)
      else
        alert '登录失败,请输入正确的用户名和密码'

  register: (user, callback, onError)=>
    url = 'http://libr.herokuapp.com/api/v1/registrations'
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
