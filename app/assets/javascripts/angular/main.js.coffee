#= require angular
#= require angular-ui-router
#= require restangular
#= require ui-bootstrap-tpls-0.11.0
#= require angular-locale_ru-ru


@MordoviaNews = angular.module('MordoviaNews', ['ui.router', 'restangular', 'ui.bootstrap'])

@MordoviaNews.run ['$rootScope', '$state', '$stateParams',
    ($rootScope, $state, $stateParams) ->
      $rootScope.$state = $state
      $rootScope.$stateParams = $stateParams
]

@MordoviaNews.config ['RestangularProvider', (RestangularProvider) ->
  RestangularProvider.setBaseUrl('api/v1')
  RestangularProvider.setRequestSuffix('.json')
]


