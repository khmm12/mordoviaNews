@MordoviaNews.controller 'LoginCtrl', ['$scope', 'Auth', 'flash', ($scope, Auth, flash) ->
  user: {
    username: ''
    password: ''
  }
  $scope.returnBack = ->
    history.back()
  $scope.login = ->
    Auth.login($scope.user).then(
      (user) ->
        $scope.returnBack()
      (error) ->
        flash.error = error.data.error
    )
  $scope.returnBack() if Auth.isAuthenticated()
]


@MordoviaNews.controller 'SignUpCtrl', ['$scope', 'Auth', 'flash', ($scope, Auth, flash) ->
  Auth.logout() if Auth.isAuthenticated()
  user: {
    name: ''
    email: ''
    username: ''
    password: ''
    password_confirmation: ''
  }
  $scope.returnBack = ->
    history.back()
  $scope.register = ->
    Auth.register($scope.user).then(
      (user) ->
        $scope.returnBack()
      (error) ->
        $scope.register_form.response_errors_keys ||= []
        for errors_key in $scope.register_form.response_errors_keys
          $scope.register_form[errors_key].errors = null
          $scope.register_form[errors_key].hasErrors = null
        $scope.register_form.response_errors_keys = []
        for errors_key of error.data.errors
          $scope.register_form.response_errors_keys.push errors_key
          $scope.register_form[errors_key].hasErrors = true
          $scope.register_form[errors_key].errors = error.data.errors[errors_key]
        null
    )
]