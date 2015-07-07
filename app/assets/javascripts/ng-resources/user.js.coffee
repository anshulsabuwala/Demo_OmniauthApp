YourNextRoomResource.factory 'User', [
  '$location'
  '$http'
  '$q'
  ($location, $http, $q) ->

    getUser: (user_id) ->
      deferred = $q.defer()
      $http.get('/api/users').success((data) ->
        deferred.resolve data.user
      ).error (data) ->
        deferred.reject data
      deferred.promise

    updateUser: (user) ->
      deferred = $q.defer()
      $http.put('/api/users', user:
        first_name: user.first_name
        last_name: user.last_name
        email: user.email
        password: user.password
        password_confirmation: user.password_confirmation
        address: user.address
        birthdate: user.birthdate
      ).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data
      deferred.promise

    updateUserAvatarUrl: (image_url) ->
      deferred = $q.defer()
      $http.put('/api/users', user:
        avatar_image_url: image_url
      ).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data
      deferred.promise

    password_reset: (user) ->
      deferred = undefined
      deferred = $q.defer()
      $http.post('/api/passwords', user: email: user.email).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data.error
      deferred.promise

    changePassword: (user) ->
      deferred = undefined
      deferred = $q.defer()
      $http.put('/api/passwords', user:
        reset_password_token: user.reset_password_token
        password: user.password
        password_confirmation: user.confirmPassword).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data.error
      deferred.promise

    sendconfirmation: ->
      deferred = $q.defer()
      $http.post('/api/confirmations').success((data) ->
        if data
          deferred.resolve data
        else
          deferred.reject data
      ).error (data) ->
        deferred.reject data
      deferred.promise

    updatePassword: (user) ->
      deferred = $q.defer()
      $http.put('/api/update_password', user:
        current_password: user.current_password
        password: user.password
        password_confirmation: user.confirmPassword).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data
      deferred.promise

    becomeTenant: (stepOneInfo, stepTwoInfo) ->
      deferred = $q.defer()
      $http.post('/api/tenants',
        tenant:
          title: stepOneInfo.userTitle
          full_name: stepOneInfo.userName
          gender: stepOneInfo.userGender
          date_of_birth: stepOneInfo.userDOB
          address_type: stepTwoInfo.userAddressType
          address: stepTwoInfo.userAddress
          city: stepTwoInfo.userCity
          postal_code: stepTwoInfo.userZipCode
          country: stepTwoInfo.userCountry
          brief_description: stepTwoInfo.userDescription
          occupation: stepTwoInfo.userOccupation
          varify_properties: stepTwoInfo.userProperties
      ).success((data) ->
        deferred.resolve(data)
      ).error((data) ->
        deferred.reject(data)
      )
      deferred.promise

    becomeLandlord: (stepOneInfo, stepTwoInfo) ->
      deferred = $q.defer()
      $http.post('/api/landlords',
        landlord:
          title: stepOneInfo.userTitle
          full_name: stepOneInfo.userName
          gender: stepOneInfo.userGender
          date_of_birth: stepOneInfo.userDOB
          address_type: stepTwoInfo.userAddressType
          address: stepTwoInfo.userAddress
          city: stepTwoInfo.userCity
          postal_code: stepTwoInfo.userZipCode
          country: stepTwoInfo.userCountry
          brief_description: stepTwoInfo.userDescription
          occupation: stepTwoInfo.userOccupation
          varify_properties: stepTwoInfo.userProperties
      ).success((data) ->
        deferred.resolve(data)
      ).error((data) ->
        deferred.reject(data)
      )
      deferred.promise

    becomeManager: (stepOneInfo, stepTwoInfo) ->
      deferred = $q.defer()
      $http.post('/api/managers',
        manager:
          company_name: stepOneInfo.managerCompanyName
          company_description: stepTwoInfo.managerCompanyDescription
          phone_number: stepTwoInfo.managerPhoneNumber
          verify_properties: stepOneInfo.managerProperties
          estate_agent: stepOneInfo.managerAgent
          contact_person_full_name: stepTwoInfo.managerFullname
          contact_person_email_address: stepTwoInfo.managerEmailAddress
          contact_person_position: stepTwoInfo.managerPosition
      ).success((data) ->
        deferred.resolve(data)
      ).error((data) ->
        deferred.reject(data)
      )
      deferred.promise

    updateAvatar: (element) ->
      payload = new FormData()
      payload.append "user[avatar]", element
      deferred = $q.defer()
      $http.put('/api/users',
        payload
        withCredentials: true
        headers:
          "Content-Type": undefined
        transformRequest: (tdata) ->
          tdata
      ).success((data) ->
        deferred.resolve(data)
      ).error((data) ->
        deferred.reject(data)
      )
      deferred.promise

    updateAvatarUrl: (element) ->
      payload = new FormData()
      payload.append "user[avatar_image_url]", element
      deferred = $q.defer()
      $http.put('/api/users',
        payload
        withCredentials: true
        headers:
          "Content-Type": undefined
        transformRequest: (tdata) ->
          tdata
      ).success((data) ->
        deferred.resolve(data)
      ).error((data) ->
        deferred.reject(data)
      )
      deferred.promise

    updateManagerContactPersonPhoto: (image_url, id) ->
      deferred = $q.defer()
      $http.put('/api/managers/' + id, manager:
        contact_person_image_url: image_url
      ).success((data) ->
        deferred.resolve data
      ).error (data) ->
        deferred.reject data
      deferred.promise
]
