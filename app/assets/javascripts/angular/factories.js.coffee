@MordoviaNews.factory 'News', ['Restangular', (Restangular) ->
  new class News
    constructor: ->
      @rest = Restangular.service('news')
      @cachedRest =
        Restangular
        .withConfig (RestangularConfigurer) ->
          RestangularConfigurer.setDefaultHttpFields {cache: true}
        .service('news')
]

@MordoviaNews.factory 'NewsCategories', ['Restangular', (Restangular) ->
    Restangular
    .withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setDefaultHttpFields {cache: true}
    .service('news_categories')
]