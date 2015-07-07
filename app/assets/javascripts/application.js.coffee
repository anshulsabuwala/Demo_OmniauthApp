#
# Angular App
#

#= require jquery.min
#= require jquery_ujs
#= require jquery-ui
#= require bootstrap
#= require angular
#= require angular-animate
#= require angular-route
#= require angular-blocks
#= require angular-resource
#= require angular-sanitize
#= require angular-touch
#= require angulartics
#= require angulartics-ga
#= require angulartics-gtm
#= require google-picker
#= require autocomplete.min


#namespace
#= require ng-app

#ng-controllers
#= require_directory ./ng-controllers

#ng-directives
#= require_directory ./ng-directives

#ng-services
#= require_directory ./ng-resources


#= require_directory ./ng-filters

#= require ng-directives/bootstrapDirectives
#= require ng-directives/formDirectives
#= require ng-directives/jQueryDirectives
#= require ng-google

YourNextRoom.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
])

YourNextRoom.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider.when("/",
    templateUrl: "/assets/ng-templates/home.html"
    controller: 'HomeCtrl'
  ).when("/logout",
    templateUrl: "/assets/ng-templates/logout.html"
    controller: 'LogoutCtrl'
  ).when("/dashboard",
    templateUrl: "/assets/ng-templates/dashboard.html"
    controller: 'HomeBaseCtrl'
  )
]

YourNextRoom.run ($rootScope, $route, $window) ->
  #get previous route and assign before page load
  $rootScope.$on "$locationChangeStart", (e, currentRoute, previousRoute) ->
    $rootScope.oldUrl = previousRoute
    $rootScope.oldHash = $window.location.hash
    return

  #assign in routescope variable after success
  $rootScope.$on "$routeChangeSuccess", (e, currentRoute, previousRoute) ->
    $rootScope.previousUrl = $rootScope.oldHash
    return

  return


