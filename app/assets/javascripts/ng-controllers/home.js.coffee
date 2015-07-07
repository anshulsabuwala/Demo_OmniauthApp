YourNextRoom.controller 'HomeCtrl', [
  '$location'
  '$scope'
  '$timeout'
  '$routeParams'
  'Session'
  'Confirmation'
  'User'
  ($location, $scope, $timeout, $routeParams, Session, Confirmation, User) ->
    $scope.signUpError = {}
    $scope.user = null
    $scope.user_type = null
    $scope.token = $routeParams.token
    $scope.signupModel = {}
    $scope.individualSignupModel = {}
    $scope.managerSignupModel = {}
    $scope.tenant_image_url = null
    $scope.landlord_image_url = null
    $scope.manager_image_url = null
    $scope.contact_person_image_url = null
    $scope.signup_step = 'signup'
    $scope.user_avatar = null
    $scope.signupNextStepModel = { userAddressType: "home", userAddress: null, userDescription: '' }
    $scope.landlordSignupNextStepModel = { userAddressType: "home", landlordCompanyDescription: '' }
    $scope.managerSignupNextStepModel = { managerAddressType: "home", managerCompanyDescription: '' }
    $scope.individualSignupModel = { userEmail: '', userConfirmEmail: '', userPassword: '', userConfirmPassword: '' }
    $scope.google_places = null

    $scope.preview_image = (input, imageId) ->
      f = new FileReader()
      f.readAsDataURL input.files[0]
      f.onload = (e) ->
        document.getElementById(imageId).src = e.target.result
        return
      return

    $scope.setAvatar = (element, imageId) ->
      $scope.user_avatar = element.files[0]
      $scope.preview_image(element, imageId)

    $scope.updateSignupForm = (step) ->
      $scope.signup_step = step

    Session.getCurrentUser(false).then (user) ->
      $scope.user = user
      $location.path '/dashboard/'
      
    $scope.login = ->
      u = undefined
      u = $scope.loginModel
      Session.login(u.email, u.password).then ((user) ->
        $('#myLoginModal').modal('hide')
        $('#myModal').modal('hide')
        $('body').removeAttr('class').removeAttr('style')

        $location.path '/dashboard/'
      ), (error) ->
        $scope.loading = false
        $scope.loginError = error

    $scope.signup = () ->
      $scope.loading = true
      u = $scope.signupModel
      Session.register(u.userAccount, u.userEmail, u.userPassword, u.userConfirmPassword).then(
        (user)->
          $scope.user = user
          $scope.loading = false
          $scope.updateSignupForm('signup_stage_2')
      , (error)->
        $scope.loading = false
        $scope.signUpError = error
      )

    $scope.becomeTenant = () ->
      $scope.loading = true
      User.becomeTenant($scope.signupModel, $scope.signupNextStepModel).then(
        (tenant)->
          if $scope.user_avatar != null
            User.updateAvatar($scope.user_avatar)
          if $scope.tenant_image_url != null
            $scope.tenant_image_url = $scope.tenant_image_url["thumbnails"][3]["url"]
            User.updateUserAvatarUrl($scope.tenant_image_url)
          $('#myModal').modal('hide')
          $('body').removeAttr('class').removeAttr('style')
          $location.path '/dashboard/'
        , (error)-> 
          $scope.loading = false
          $scope.tenantError = error
      )

    $scope.landlordSignup = () ->
      $scope.loading = true
      u = $scope.individualSignupModel
      Session.register(u.userAccount, u.userEmail, u.userPassword, u.userConfirmPassword).then(
        (user)->
          $scope.user = user
          $scope.loading = false
          $scope.updateSignupForm('individual_stage_2')
      , (error)->
          $scope.loading = false
          $scope.individualSignUpError = error
      )

    $scope.becomeLandlord = () ->
      $scope.loading = true
      User.becomeLandlord($scope.individualSignupModel, $scope.landlordSignupNextStepModel).then(
        (landlord)->
          if $scope.user_avatar != null
            User.updateAvatar($scope.user_avatar)
          else
            if $scope.landlord_image_url != null
              $scope.landlord_image_url = $scope.landlord_image_url["thumbnails"][3]["url"]
              User.updateUserAvatarUrl($scope.landlord_image_url)
          $('#myModal').modal('hide')
          $('body').removeAttr('class').removeAttr('style')
          $location.path '/dashboard/'
        , (error)-> 
          $scope.loading = false
          $scope.landlordError = error
      )

    $scope.managerSignup = () ->
      $scope.loading = true
      u = $scope.managerSignupModel
      Session.register(u.managerAccountType, u.userEmail, u.userPassword, u.userConfirmPassword).then(
        (user)->
          $scope.user = user
          $scope.loading = false
          $scope.updateSignupForm('business_stage_2')
      , (error)->
        $scope.loading = false
        $scope.managerSignUpError = error
      )

    $scope.becomeManager = () ->
      $scope.loading = true
      User.becomeManager($scope.managerSignupModel, $scope.managerSignupNextStepModel).then(
        (manager)->
          if $scope.user_avatar != null
            User.updateAvatar($scope.user_avatar)
          else
            if $scope.manager_image_url != null
              $scope.manager_image_url = $scope.manager_image_url["thumbnails"][3]["url"]
              User.updateManagerAvatarUrl($scope.manager_image_url)
          if $scope.contact_person_image_url != null
            $scope.contact_person_image_url = $scope.contact_person_image_url["thumbnails"][3]["url"]
            User.updateManagerContactPersonPhoto($scope.contact_person_image_url, manager.id)
            $('#myModal, #myLoginModal').modal('hide')
          $location.path '/dashboard/'
        , (error)-> 
          $scope.loading = false
          $scope.managerError = error
      )
]
