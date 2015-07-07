YourNextRoomResource.factory "Property", [
  "$resource"
  ($resource) ->
    return $resource("/properties/:id.json")
]