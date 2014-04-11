libr = angular.module 'libr.services.localstorage', []

class LocalStorageUtils

  user = null

  constructor: ()->
    user = JSON.parse localStorage.getItem('user')

  getUserId: ()=>
    user.id


libr.service 'LocalStorageUtils', LocalStorageUtils

