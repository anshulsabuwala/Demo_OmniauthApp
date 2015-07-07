YourNextRoom.controller 'HomeBaseCtrl', [
  '$location'
  '$rootScope'
  '$scope'
  '$timeout'
  '$routeParams'
  'Session'
  'User'
  ($location, $rootScope, $scope, $timeout, $routeParams, Session, User) ->

    $rootScope.location = $location
    $scope.user = null
    $scope.loading = false

    Session.getCurrentUser(false).then((user)->
      $scope.user = user
    )
]
