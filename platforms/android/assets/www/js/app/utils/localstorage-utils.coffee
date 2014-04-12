libr = angular.module 'libr.services.localstorage', []

class LocalStorageUtils

  user = null

  constructor: ()->
    user = JSON.parse localStorage.getItem('user')

  getUserId: ()=>
    user.id
  getUserName: ()->
    user.name
  getUserToken: ()->
    user.token
  getUserAvatar: ()->
    user.avatar
  getUserEmail: ()->
    user.email


libr.service 'LocalStorageUtils', LocalStorageUtils

