YourNextRoomDirectives.directive('autoFocus', () ->
  (scope, element) ->
    element.focus()
)
YourNextRoomDirectives.directive 'match', ($parse) ->
  require: 'ngModel'
  restrict: 'A'
  link: (scope, element, attrs, ctrl) ->
    modelToMatch = element.attr('match')

    ctrl.$validators.mismatch = (modelValue, viewValue) ->
      viewValue == scope.$eval(modelToMatch)

    return
YourNextRoomDirectives.directive 'datepicker', ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope, el, attr, ngModel) ->
    el.datepicker
      dateFormat: 'mm-dd-yy'
      onSelect: (dateText) ->
        scope.$apply ->
          ngModel.$setViewValue dateText

YourNextRoomDirectives.directive('nextCarousel', () ->
  (scope, element) ->
    element.on('click', () ->
      carousel = $('#carousel-example-generic')
      this.$active = carousel.find('.item.active')
      this.$items = this.$active.parent().children()
      return if (this.$items.index(this.$active) == this.$items.length - 1)
      carousel.carousel('next')
    )
)

YourNextRoomDirectives.directive('prevCarousel', () ->
  (scope, element) ->
    element.on('click', () ->
      carousel = $('#carousel-example-generic')
      this.$active = carousel.find('.item.active')
      this.$items = this.$active.parent().children()
      return if (this.$items.index(this.$active) == 0)
      carousel.carousel('prev')
    )
)

YourNextRoomDirectives.directive('myDashboardCarousel', () ->
  (scope, element) ->
    $(element).carousel({interval: false})
)

YourNextRoomDirectives.directive('myCarousel', () ->
  (scope, element) ->
    $(element).carousel({interval: false})
)