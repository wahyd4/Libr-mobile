libr = angular.module 'libr.directives.swipeBack', []

class SwipeBack
  @$inject: ['$ionicGesture', '$window']
  constructor: (@$ionicGesture, @$window)->
    return {
    restrict: 'A',
    link: (scope, element, attribute)=>
      @$ionicGesture.on 'swiperight', (event)=>
        @$window.history.back()
      , element
    }

libr.directive 'swipeBack', ['$ionicGesture', '$window', SwipeBack]
