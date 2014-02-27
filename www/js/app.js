// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'libr.services' is found in services.js
// 'libr.controllers' is found in controllers.js
angular.module('libr', ['ionic', 'libr.services', 'libr.controllers', 'libr.services.scan',
        'libr.services.geolocation',
        'libr.services.auth',
        'libr.services.books',
        'libr.controllers.home',
        'libr.controllers.main',
        'libr.controllers.settings',
        'libr.controllers.books',
        'libr.controllers.location',
        'libr.controllers.login'
    ])

    .config(function ($stateProvider, $urlRouterProvider) {

        // Ionic uses AngularUI Router which uses the concept of states
        // Learn more here: https://github.com/angular-ui/ui-router
        // Set up the various states which the app can be in.
        // Each state's controller can be found in controllers.js
        $stateProvider

            // setup an abstract state for the tabs directive
            .state('tab', {
                url: "/tab",
                abstract: true,
                templateUrl: "templates/tabs.html"
            })

            // the pet tab has its own child nav-view and history
            .state('tab.home', {
                url: '/home',
                views: {
                    'home-tab': {
                        templateUrl: 'templates/libr-index.html',
                        controller: 'HomeCtrl'
                    }
                }
            })

            .state('tab.books', {
                url: '/books',
                views: {
                    'books-tab': {
                        templateUrl: 'templates/my-books.html',
                        controller: 'BooksController'
                    }
                }
            })

            .state('tab.locations', {
                url: '/locations',
                views: {
                    'locations-tab': {
                        templateUrl: 'templates/locations.html',
                        controller: 'LocationController'
                    }
                }
            })
            .state('login', {
                url: '/login',
                templateUrl: 'templates/login.html',
                controller: 'LoginController'
            })
            .state('book-detail', {
                url: '/book/:isbn',
                templateUrl: 'templates/book-detail.html',
                controller: 'BookDetailController'
            })

            .state('tab.settings', {
                url: '/settings',
                views: {
                    'settings-tab': {
                        templateUrl: 'templates/settings.html',
                        controller: 'SettingsController'
                    }
                }
            });

        // if none of the above states are matched, use this as the fallback
        $urlRouterProvider.otherwise('/login');


    });

