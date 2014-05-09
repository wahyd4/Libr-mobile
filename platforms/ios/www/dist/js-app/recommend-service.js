(function() {
  var RecommendService, libr,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  libr = angular.module('libr.services.recommend', []);

  RecommendService = (function() {
    RecommendService.$injector = ['GeolocationService', '$http', 'Constant'];

    function RecommendService(GeolocationService, $http, Constant) {
      this.GeolocationService = GeolocationService;
      this.$http = $http;
      this.Constant = Constant;
      this.changeRecommendAction = __bind(this.changeRecommendAction, this);
      this.popularBooksAroundMe = __bind(this.popularBooksAroundMe, this);
    }

    RecommendService.prototype.getActionSheetList = function() {
      var actionList;
      actionList = [];
      actionList.push({
        text: '随机找几本书看看'
      });
      actionList.push({
        text: "你可能喜欢的书"
      });
      this.GeolocationService.getLocations((function(_this) {
        return function(locations) {
          var locationIds;
          locationIds = [];
          locations.map(function(location) {
            locationIds.push(location.id);
            location = {
              text: "" + location.address + "附近流行的书"
            };
            return actionList.push(location);
          });
          localStorage.setItem('recommend_action_sheet_arr', JSON.stringify(locationIds));
          return localStorage.setItem('recommend_action_sheet_full_arr', JSON.stringify(actionList));
        };
      })(this));
      return actionList;
    };

    RecommendService.prototype.popularBooksForMe = function(callback, error) {
      var email, token;
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        url: this.Constant.baseUrl + ("/recommend/me?user_email=" + email + "&user_token=" + token),
        method: 'GET',
        timeout: 15000
      }).success(function(data, status, headers, config) {
        return callback(data);
      }).error(function(data) {
        return error(data);
      });
    };

    RecommendService.prototype.randomBooks = function(callback, error) {
      var email, token;
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        url: this.Constant.baseUrl + ("/recommend/random?user_email=" + email + "&user_token=" + token),
        method: 'GET',
        timeout: 15000,
        cache: true
      }).success(function(data, status, headers, config) {
        return callback(data);
      }).error(function(data) {
        return error(data);
      });
    };

    RecommendService.prototype.popularBooksAroundMe = function(locationId, callback, error) {
      var email, token;
      email = localStorage.getItem('email');
      token = localStorage.getItem('token');
      return this.$http({
        url: this.Constant.baseUrl + ("/recommend/locations/" + locationId + "?user_email=" + email + "&user_token=" + token),
        method: 'GET',
        timeout: 15000,
        cache: true
      }).success(function(data, status, headers, config) {
        console.log('数据', data);
        return callback(data);
      }).error(function(data) {
        return error(data);
      });
    };

    RecommendService.prototype.changeRecommendAction = function(index, callback, error) {
      var locations;
      console.log('index====', index);
      if (index === 0) {
        return this.randomBooks(callback, error);
      } else if (index === 1) {
        return this.popularBooksForMe(callback, error);
      } else {
        locations = JSON.parse(localStorage.getItem('recommend_action_sheet_arr'));
        console.log(locations[index - 2], 'index......');
        return this.popularBooksAroundMe(locations[index - 2], function(result) {
          console.log('callback....', result);
          return callback(result);
        }, function(errorMessage) {
          return error(errorMessage);
        });
      }
    };

    return RecommendService;

  })();

  libr.service('RecommendService', RecommendService);

}).call(this);
