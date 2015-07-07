YourNextRoomDirectives.directive("loading", ->
  restrict: "E"
  replace: true
  template: "<div class=\"loading\">
              <div class=\"loaderimgText\" id=\"loaderimgText\">
              <div><img src=\"/assets/ajax-loader.gif\" /></div>
              <div class=\"backTransparant\"></div>
              </div>
            </div>"
  link: (scope, element, attr) ->
    scope.$watch "loading", (val) ->
      if val
        $(element).show()
      else
        $(element).hide()
      return

    return
)

YourNextRoomDirectives.directive("openDialog", ->
  restrict: "A"
  openDialog = link: (scope, element, attrs) ->
    openDialog = ->
      element = $(attrs.modalName)
      element.modal "show"

      element.on "keyup.dismiss.bs.modal", $.proxy((e) ->
        if e.isDefaultPrevented()
          return
        if e.which is 27
          scope.$apply "updateSignupForm('signup')"
          element.modal "hide"
        return
      , this)

    element.bind "click", openDialog
    return

  openDialog
)