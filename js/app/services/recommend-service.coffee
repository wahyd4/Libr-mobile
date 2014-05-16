libr = angular.module 'libr.services.recommend', []

class RecommendService

  @$injector: ['GeolocationService', '$http', 'Constant']
  constructor: (@GeolocationService, @$http, @Constant)->

  getActionSheetList: ()->
    actionList = []
    actionList.push {text: '随便看看吧'}
    actionList.push {text: "你可能喜欢的书"}
    @GeolocationService.getLocations (locations)=>
      locationIds = []
      locations.map (location)->
        locationIds.push location.id
        location = {text: "#{location.address}附近流行的书"}
        actionList.push location
      localStorage.setItem 'recommend_action_sheet_arr', JSON.stringify(locationIds)
      localStorage.setItem 'recommend_action_sheet_full_arr', JSON.stringify(actionList)
    actionList


  popularBooksForMe: (callback, error)->
    email = localStorage.getItem 'email'
    token = localStorage.getItem 'token'
    @$http(
      url: @Constant.baseUrl + "/recommend/me?user_email=#{email}&user_token=#{token}"
      method: 'GET'
      timeout: 15000
    )
    .success (data, status, headers, config)->
      callback data
    .error (data)->
      error data

  randomBooks: (callback, error)->
    email = localStorage.getItem 'email'
    token = localStorage.getItem 'token'
    @$http(
      url: @Constant.baseUrl + "/recommend/random?user_email=#{email}&user_token=#{token}"
      method: 'GET'
      timeout: 15000
      cache: false
    )
    .success (data, status, headers, config)->
      callback data
    .error (data)->
      error data


  popularBooksAroundMe: (locationId, callback, error)=>
    email = localStorage.getItem 'email'
    token = localStorage.getItem 'token'
    @$http(
      url: @Constant.baseUrl + "/recommend/locations/#{locationId}?user_email=#{email}&user_token=#{token}"
      method: 'GET'
      timeout: 15000
      cache: true
    )
    .success (data, status, headers, config)->
      console.log '数据', data
      callback data
    .error (data)->
      error data

  changeRecommendAction: (index, callback, error)=>
    console.log 'index====', index
    if index is 0
      @randomBooks(callback, error)
    else if index is 1
      @popularBooksForMe callback, error
    else
      locations = JSON.parse(localStorage.getItem('recommend_action_sheet_arr'))
      console.log locations[index - 2],'index......'
      @popularBooksAroundMe locations[index - 2], (result)->
        console.log 'callback....', result
        callback result
      , (errorMessage)->
        error errorMessage


libr.service 'RecommendService', RecommendService
