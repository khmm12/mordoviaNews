@MordoviaNews.controller 'NewsIndexCtrl', ['$scope', '$sce', '$modal', '$state', '$stateParams', 'News', 'news_categories', 'category', 'page', 'pageTitle', ($scope, $sce, $modal, $state, $stateParams, News, news_categories, news_category, news_page, page_title) ->
  $scope.itemsPerPage = 5
  $scope.page_title = page_title

  # Pagination
  $scope.paginationShow = ->
    $scope.totalItems > $scope.itemsPerPage
  $scope.pageChanged = ->
    $state.go $state.current.name, {page: $scope.currentPage}

  # Page helper
  $scope.getCategory = (news_object) ->
    _.find(news_categories, (category) ->
      news_object.category_id is category.id
    )
  $scope.to_trusted = (html_code) ->
    $sce.trustAsHtml(html_code)
  $scope.modal_show = (news) ->
    modal = $modal.open {
      templateUrl: 'angular/news.modalShow'
      controller: NewsShowModalCtrl
      size: 'lg'
      resolve: {
        id: ->
          news.id
      }
    }

  # Getting content function
  $scope.getNews = ->
    $scope.isLoaded = false
    $scope.news = []
    requestNewsArguments = {page: news_page, page_size: $scope.itemsPerPage}
    requestNewsLengthArguments = {length: true}
    requestNewsLengthArguments.news_category_id= requestNewsArguments.news_category_id = news_category.id if news_category
    # Getting news for this page
    News.cachedRest.getList(requestNewsArguments).then (news) ->
      $scope.news = news
      # Getting length of all news objects
      News.cachedRest.one().get(requestNewsLengthArguments).then (result) ->
        # Assign received data
        $scope.totalItems = parseInt(result)
        $scope.isLoaded = true
        $scope.currentPage = news_page

  # Get content 
  $scope.getNews()
]

NewsShowModalCtrl = ['$scope', 'News', '$sce', '$modalInstance', 'id', '$timeout', '$window', '$localStorage', ($scope, News, $sce, $modalInstance, id, $timeout, $window, $localStorage) ->
  # Сrutch, without any timeout it doesn't work
  $timeout((->
    angular.element('.modal-content').css('height', $window.innerHeight * 0.9 + 'px'))
    0
  )
  $scope.new = {}
  $scope.isLoaded = false
  News.rest.one(id).get().then (news) ->
    $scope.new = news
    pagesStatistics($localStorage, news.id)
    $scope.isLoaded = true
  $scope.to_trusted = (html_code) ->
    $sce.trustAsHtml(html_code)
]

@MordoviaNews.controller 'NewsShowCtrl', ['$scope', 'News', '$stateParams', '$sce', 'news_categories', '$localStorage', ($scope, News, $stateParams, $sce, news_categories, $localStorage) ->
  $scope.storage = $localStorage.$default {
    viewedNews: {
      ids: { }
      value: 0
    }
  }

  $scope.new = {}
  $scope.isLoaded = false
  $scope.getCategory = (news_object) ->
    _.find(news_categories, (category) ->
      news_object.category_id is category.id
    )
  News.rest.one($stateParams.news_id).get().then (news) ->
    $scope.new = news
    $scope.comments = news.getList('news_comments').$object
    pagesStatistics($localStorage, news.id)
    $scope.isLoaded = true

  $scope.comment = {
    model: {
      content: ''
    }
    reset: ->
      $scope.comment.model.content = ''
      $scope.new_comment.$setPristine()
      $scope.comment.isFormShowen = false
    post: ->
      $scope.new.post('news_comments', $scope.comment.model).then(
        (comment) ->
          $scope.comments.unshift comment
          $scope.comment.reset()
        (result) ->
          console.log result
      )
  }

  $scope.to_trusted = (html_code) ->
    $sce.trustAsHtml(html_code)
]

@MordoviaNews.controller 'NewsAsideMenuCtrl', ['$scope', 'news_categories', ($scope, news_categories) ->
  $scope.items = []
  for category in news_categories
    item = {
      title: category.title
      link: category.title_latin
    }
    $scope.items.push item
]

pagesStatistics = ($localStorage, news_id) ->
    storage = $localStorage.$default {
      viewedNews: {
        ids: { }
        value: 0
      }
    }
    if storage.viewedNews.ids[news_id]
      storage.viewedNews.ids[news_id] += 1
    else
      storage.viewedNews.ids[news_id] = 1
      storage.viewedNews.value += 1
    null