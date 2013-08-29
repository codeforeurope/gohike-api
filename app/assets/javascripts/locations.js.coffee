# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  window.Gmaps.map.callback = () ->
    map = Gmaps.map.map
    map.setOptions({
      auto_adjust: true,
      zoomControl: true,
      streetViewControl: false,
      scaleControl: false,
      rotateControl: false,
      mapTypeControl: false,
      panControl: false,
      scrollwheel: false
    })
    geocoder = new google.maps.Geocoder()
    crosshairShape = {coords: [0, 0, 0, 0], type: 'rect'}
    mapReady = false

    marker = new google.maps.Marker({
      map: map,
      icon: 'http://www.daftlogic.com/images/cross-hairs.gif',
      shape: crosshairShape
    })
    marker.bindTo('position', map, 'center')
    google.maps.event.addListener map, 'idle', () ->
      currentCenter = map.getCenter()
      request = {location: currentCenter }
      $address = $("#location_address")
      $city = $("#location_city")
      $postal_code = $("#location_postal_code")
      $latitude = $("#location_latitude")
      $longitude = $("#location_longitude")

      if mapReady
        $latitude.val(currentCenter.lat())
        $longitude.val(currentCenter.lng())
        geocoder.geocode request, (results, status) ->
          if status == google.maps.GeocoderStatus.OK and results[0]
            parts = results[0].formatted_address.split(", ")
            city_parts = parts[1].split(" ")
            $address.val(parts[0])
            $city.val(city_parts.pop())
            $postal_code.val(city_parts.join(" "))


      mapReady = true



  $("form").on "change","#location_city_id", (e)->
    latitude = $(this).find(":selected").data("latitude")
    longitude = $(this).find(":selected").data("longitude")
    Gmaps.map.map.setCenter( Gmaps.map.createLatLng(latitude, longitude))

    $("input[name*=address],input[name*=city], input[name*=postal_code],input[name*=search_map]").prop("disabled", false)
    $(".overlay").hide()

  $(".search-map").on 'keydown', (e)->
    if e.keyCode == 13
      e.preventDefault()
      e.stopPropagation()
      request = {address: $(this).val() }
      geocoder = new google.maps.Geocoder()
      map = Gmaps.map.map
      geocoder.geocode request, (results, status) ->
        best_result = results[0]
        if status == google.maps.GeocoderStatus.OK and best_result
          map.setCenter(best_result.geometry.location)