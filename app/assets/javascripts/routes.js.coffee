# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".waypoint-list").sortable({
    connectWith: ".connected"
    receive: (event, ui) ->
      console.log(event, ui)
    update: (event, ui) ->
      console.log(event, ui)
    deactivate: (event, ui) ->
      console.log(event, ui)

  }).disableSelection()

