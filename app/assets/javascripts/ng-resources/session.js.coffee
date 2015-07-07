YourNextRoomResource.factory('Session', ['$location', '$http', '$q',($location, $http, $q) ->
  _currentUser = null

  login: (email, password) ->
    deferred = undefined
    deferred = $q.defer()
    $http.post('/api/sessions', user:
      email: email
      password: password).success((data) ->
      _currentUser = data.user
      deferred.resolve _currentUser
    ).error (data) ->
      deferred.reject data.error
    deferred.promise
  logout: () ->
    deferred = $q.defer()
    $http.delete("/api/sessions").then ->
      _currentUser = null
      deferred.resolve()
    deferred.promise
  getCurrentUser: (forceUpdate) ->
    deferred = undefined
    deferred = $q.defer()
    if !forceUpdate and @isAuthenticated()
      deferred.resolve _currentUser
    else
      $http.get('/api/users').success((data) ->
        _currentUser = data.user
        deferred.resolve _currentUser
      ).error (data) ->
        deferred.reject data
    deferred.promise
  isAuthenticated: ->
    ! !_currentUser
  
  register: (accountType, email, password, confirmPassword) ->
    deferred = $q.defer()
    $http.post('/api/users',
      user:
        account_type: accountType
        email: email
        password: password
        password_confirmation: confirmPassword
    ).success((data) ->
      _currentUser = data.user
      deferred.resolve(_currentUser)
    ).error((data) ->
      deferred.reject(data.errors)
    )
    deferred.promise

  registerLandlord: (accountType, email, password, confirmPassword) ->
    deferred = $q.defer()
    $http.post('/api/users',
      user:
        account_type: accountType
        email: email
        password: password
        password_confirmation: confirmPassword
    ).success((data) ->
      deferred.resolve(data)
    ).error((data) ->
      deferred.reject(data)
    )
    deferred.promise
])
