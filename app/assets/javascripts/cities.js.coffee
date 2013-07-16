# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#city_country_code").change (e)->
    console.log("changed", e, $(this).val())
    select_wrapper = $(this).parent().next()
    country_code = $(this).val()
    url = "/state_province_list?country_code=#{country_code}"
    select_wrapper.load(url)

jQuery ->
  $('#city_radius').slider()
  console.log("city radius loaded")
