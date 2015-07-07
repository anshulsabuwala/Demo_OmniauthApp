YourNextRoom.controller 'LogoutCtrl', [
  "$location"
  "$scope"
  "$rootScope"
  "Session"
  ($location, $scope, $rootScope, Session) ->

    Session.logout().then(
      (user)->
        $location.path '/'
    )

]