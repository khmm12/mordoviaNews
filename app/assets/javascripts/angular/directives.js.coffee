@MordoviaNews.directive 'backButton', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      history.back()
      scope.$apply()


@MordoviaNews.directive 'flashMessages', ->
  restrict: 'AEC'
  template: """
            <div flash-alert active-class="in" class="alert fade">
              <span class="alert-message">{{flash.message}}</span>
            </div>
            """