libr = angular.module 'libr.controllers.login', ['ionic']

class LoginController

  @$inject: ['$scope', 'AuthService', '$state', '$ionicModal']
  constructor: (@$scope, @AuthService, @$state, @$ionicModal)->
    if isUserLogedIn() then @$state.go('tab.home')
    @$scope.login = @login
    @$scope.registerForm = @registerForm
    @$scope.registerUser = @registerUser
    @$scope.closeDialog = @closeDialog
    @$ionicModal.fromTemplateUrl 'templates/modal/registration.html', (modal)=>
      @$scope.modal = modal
    , {
        scope: @$scope,
        animation: 'slide-in-up'
      }


  login: (user)=>
    if !user || user.email == '' || user.password == '' || user.email == undefined || user.password == undefined
      alert '请输入有效的用户名和密码'
      return
    @AuthService.login user, (result)=>
      localStorage.setItem 'token', result.user.token
      localStorage.setItem 'avatar', result.user.avatar
      localStorage.setItem 'username', result.user.name
      localStorage.setItem 'email', user.email
      @$state.go 'tab.home'

  isUserLogedIn = ()->
    if localStorage.getItem('token') isnt null and localStorage.getItem('email') isnt null
      true
    else
      false

  registerForm: =>
    @$scope.modal.show()

  registerUser: (user)=>
    if !user || user.email == '' || user.password == '' || user.email == undefined || user.password == undefined
      alert '请输入有效的用户名和密码'
      return
    else
      @AuthService.register user, (result, status)=>
        if status is 201
          alert '注册成功，请返回登录'
          @$scope.modal.hide()
        else
          alert '注册失败,是确认输入正确，并重试'
      , (error)=>
        alert '注册失败,是确认输入正确，并重试'
        console.log "registerError", error
  closeDialog: =>
    @$scope.modal.hide()


libr.controller 'LoginController', LoginController