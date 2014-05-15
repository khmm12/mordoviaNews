#= require angular
#= require angular-ui-router
#= require restangular
#= require angular-devise
#= require ngStorage
#= require angular-flash
#= require ui-bootstrap-tpls-0.11.0
#= require angular-locale_ru-ru


@MordoviaNews = angular.module('MordoviaNews', ['ui.router', 'restangular', 'ngStorage', 'Devise', 'ui.bootstrap', 'angular-flash.service', 'angular-flash.flash-alert-directive'])

@MordoviaNews.run ['$rootScope', '$state', '$stateParams', 'Auth', '$localStorage', 'News',
    ($rootScope, $state, $stateParams, Auth, $localStorage, News) ->
      Auth.currentUser()
      $rootScope.$state = $state
      $rootScope.$stateParams = $stateParams
      $rootScope.Auth = Auth
      storage = $localStorage.$default {
        viewedNews: {
          ids: { }
          value: 0
        }
      }
      $rootScope.newsViewed = storage.viewedNews
      News.cachedRest.one().get({length: true}).then (result) ->
        $rootScope.newsLength = parseInt(result)
      $rootScope.resetViewedNews = ->
        $rootScope.newsViewed.ids = {}
        $rootScope.newsViewed.value = 0



]

@MordoviaNews.config ['RestangularProvider', (RestangularProvider) ->
  RestangularProvider.setBaseUrl('api/v1')
  RestangularProvider.setRequestSuffix('.json')
]

@MordoviaNews.config ['AuthProvider', (AuthProvider) ->
  path = (path) ->
    "api/v1/users/#{path}.json"

  AuthProvider.ignoreAuth true
  AuthProvider.loginPath path('sign_in')
  AuthProvider.logoutPath path('sign_out')
  AuthProvider.registerPath "api/v1/users.json"
]


@MordoviaNews.config ['flashProvider', (flashProvider) ->
  flashProvider.errorClassnames.push('alert-danger')
]
