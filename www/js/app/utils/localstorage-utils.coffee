libr = angular.module 'libr.services.localstorage', []

class LocalStorageUtils

  getUser: ()->
    JSON.parse localStorage.getItem('user')

  getUserId: ()->
    user = @getUser()
    user.id
  getUserName: ()->
    user = @getUser()
    user.name
  getUserToken: ()->
    user = @getUser()
    user.token
  getUserAvatar: ()->
    user = @getUser()
    user.avatar
  getUserEmail: ()->
    user = @getUser()
    user.email
  isUserLogedIn: ()->
    user = @getUser()
    user isnt null && @getUserEmail() isnt null && @getUserToken() isnt null


libr.service 'LocalStorageUtils', LocalStorageUtils

