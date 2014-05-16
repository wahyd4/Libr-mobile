libr = angular.module 'libr.controllers.login', ['ionic']

class LoginController

  @$inject: ['$scope', 'AuthService', '$state', '$ionicModal', 'IonicUtils', 'LocalStorageUtils']
  constructor: (@$scope, @AuthService, @$state, @$ionicModal, @IonicUtils, @LocalStorageUtils)->
    if @LocalStorageUtils.isUserLogedIn() then @$state.go('tab.home')
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
    @IonicUtils.initCustomLoading(@$scope)

  login: (user)=>
    if !user || user.email == '' || user.password == '' || user.email == undefined || user.password == undefined
      @IonicUtils.showLoading(@$scope, '请输入有效的用户名和密码')
      return
    @AuthService.login user,
    (result)=>
      localStorage.setItem 'token', result.user.token
      localStorage.setItem 'avatar', result.user.avatar
      localStorage.setItem 'username', result.user.name
      localStorage.setItem 'email', user.email
      localStorage.setItem 'user', JSON.stringify result.user
      @$state.go 'tab.home'
    , (data)=>
      @IonicUtils.showLoading(@$scope, data)

  registerForm: =>
    @$scope.modal.show()

  registerUser: (user)=>
    if !user || user.email == '' || user.password == '' || user.email == undefined || user.password == undefined
      @IonicUtils.showLoading(@$scope, '用户名或密码错误，请重试')
      return
    else
      @AuthService.register user, (result, status)=>
        if status is 201
          alert '注册成功，请返回登录'
          @$scope.modal.hide()
        else
          @IonicUtils.showLoading(@$scope, '注册失败,请确认是否输入正确，并重试')
      , (error)=>
        @IonicUtils.showLoading(@$scope, '注册失败,请确认是否输入正确，并重试')
        console.log "registerError", error
  closeDialog: =>
    @$scope.modal.hide()


libr.controller 'LoginController', LoginController