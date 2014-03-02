libr = angular.module 'libr.services.recommend', []

class RecommendService

  @$injector: ['GeolocationService']
  constructor: (@GeolocationService)->

  getActionSheetList: ()->
    actionList = []
    actionList.push {text: "我可能喜欢的书"}
    @GeolocationService.getLocations (locations)=>
      locations = locations.map (location)->
        location = {text: "#{location.address}附近流行的书"}
        actionList.push location
    actionList


libr.service 'RecommendService', RecommendService
