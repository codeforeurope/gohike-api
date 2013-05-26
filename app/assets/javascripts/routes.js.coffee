# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".waypoint-list").sortable({
    connectWith: ".connected"
    receive: (event, ui) ->
      if (event.target.id == "waypoints")
        console.log(event, ui)
#    update: (event, ui) ->
#      console.log(event, ui)
    deactivate: (event, ui) ->
      if (event.target.id == "waypoints")
        waypoints = [];
        $(this).children().each (index, element) ->
          waypoints.push({location_id: $(element).data("location-id")})

        $.ajax(window.location.href + "/waypoints",
        {type: "PUT", contentType: "application/json", dataType: "json", data: JSON.stringify({waypoints: waypoints})}).success((data, status, xhr)->
          console.log(data, status, xhr)
        )

  }).disableSelection()

