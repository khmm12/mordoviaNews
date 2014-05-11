@MordoviaNews.directive 'backButton', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      history.back()
      scope.$apply()