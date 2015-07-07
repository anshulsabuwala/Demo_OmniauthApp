window.YourNextRoomResource = angular.module 'YourNextRoomResource', []
window.YourNextRoomDirectives = angular.module 'YourNextRoomDirectives', []
window.YourNextRoom = angular.module "YourNextRoom", [
  "angular-blocks"
  "ngAnimate"
  "ngResource"
  "YourNextRoomResource"
  "YourNextRoomDirectives"
  'ngRoute'
  "ngSanitize"
  "lk-google-picker"
  "google.places"
  ]
