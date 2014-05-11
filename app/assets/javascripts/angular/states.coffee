@MordoviaNews.config ['$stateProvider', '$urlRouterProvider', ($stateProvider,   $urlRouterProvider) ->
  $urlRouterProvider
  .otherwise('/')

  $stateProvider
  .state('home', {
      url: '/'
      templateUrl: getTemplateUrl 'home'
    }
  )
  .state('about', {
      url: '/about'
      templateUrl: getTemplateUrl 'about'
    }
  )
  .state('news', {
      url: '/news'
      abstract: true
      views: {
        '': {
          template: '<div ui-view></div>'
        }
        'AsideMenu': {
          templateUrl: getTemplateUrl 'news.asidemenu'
          controller: 'NewsAsideMenuCtrl'
        }
      }
      resolve: {
        news_categories: (NewsCategories) ->
          NewsCategories.getList()
      }
    }
  )
  .state('news.show', {
      url: '/show/:news_id'
      templateUrl: getTemplateUrl 'news.show'
      controller: 'NewsShowCtrl'
    }
  )
  .state('news.all', {
      url: '?page'
      templateUrl: getTemplateUrl 'news.index'
      controller: 'NewsIndexCtrl'
      resolve: {
        category: ->
          null
        page: getPage
        pageTitle: ->
          'Все новости'
      }
    }
  )
  .state('news.category_all', {
      url: '/category/:category_name?page'
      templateUrl: getTemplateUrl 'news.index'
      controller: 'NewsIndexCtrl'
      resolve: {
        category: ($stateParams, NewsCategories, news_categories) ->
          _.find(news_categories, (category) ->
            $stateParams.category_name is category.title_latin
          )
        page: getPage
        pageTitle: (category) ->
          category.title
      }
    }
  )
]

getTemplateUrl = (url) ->
  templateUrl = 'angular/'
  "/#{templateUrl}#{url}"

getPage = ($stateParams) ->
  $stateParams.page || 1