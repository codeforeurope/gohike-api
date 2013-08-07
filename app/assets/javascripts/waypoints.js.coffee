jQuery ->
  $(".waypoint-list").sortable({
    connectWith: ".connected"
    receive: (event, ui) ->
      if (event.target.id == "waypoints")
        console.log(event, ui)
    deactivate: (event, ui) ->
      if (event.target.id == "waypoints")
        waypoints = []
        $(this).children().each (index, element) ->
          waypoints.push({location_id: $(element).data("location-id")})

        $.ajax(window.location.href + "/waypoints",
        {type: "PUT", contentType: "application/json", dataType: "json", data: JSON.stringify({waypoints: waypoints})}).success((data, status, xhr)->
          console.log(data, status, xhr)
        )

  }).disableSelection()

  $(".search-locations").on "keyup", (e)->
    exclude = []
    $("#waypoints").children().each (index, element) ->
      exclude.push($(element).data("location-id"))

    $.get($(this).data("search-url") + "?term=" + $(this).val() + "&exclude=" + exclude.join(",")).success (data, status, xhr)->
      $("#locations").html(data);
