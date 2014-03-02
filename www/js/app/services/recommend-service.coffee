libr = angular.module 'libr.services.recommend', []

class RecommendService
  baseUrl = 'http://libr.herokuapp.com/api/v1'
  email = localStorage.getItem 'email'
  token = localStorage.getItem 'token'

  @$injector: ['GeolocationService', '$http']
  constructor: (@GeolocationService, @$http)->

  getActionSheetList: ()->
    actionList = []
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
    @$http(
      url: "#{baseUrl}/recommend/me?user_email=#{email}&user_token=#{token}"
      method: 'GET'
      cache: true
    )
    .success (data, status, headers, config)->
        callback data
    .error (data)->
        error data

  popularBooksAroundMe: (locationId, callback, error)=>
    @$http(
      url: "#{baseUrl}/recommend/locations/#{locationId}?user_email=#{email}&user_token=#{token}"
      method: 'GET'
      cache: true
    )
    .success (data, status, headers, config)->
        console.log '数据', data
        callback data
    .error (data)->
        error data

  changeRecommendAction: (index, callback, error)=>
    if index is 0
      @popularBooksForMe callback, error
    else
      locations = JSON.parse(localStorage.getItem('recommend_action_sheet_arr'))
      @popularBooksAroundMe locations[index - 1], (result)->
        console.log 'callback....', result
        callback result
      , (errorMessage)->
        error errorMessage


libr.service 'RecommendService', RecommendService
