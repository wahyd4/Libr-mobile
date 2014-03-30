libr = angular.module 'libr.services.utils', []

class IonicUtils

  @$inject: ['$timeout']
  constructor: (@$timeout)->

  initCustomLoading: (scope)->
    scope.data = {
      isLoading: false
      text: null
    }

  showLoading: (scope, text, timing = 3000)->
    scope.data = {
      isLoading: true
      text: text
    }
    @$timeout ()=>
      @initCustomLoading(scope)
    , timing

libr.service 'IonicUtils', IonicUtils