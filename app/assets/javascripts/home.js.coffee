# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $('a.publish').on 'ajax:success', (event,data,c)->
    alert("Content was published. Version: " + data.version + "<br> Size:" + data.length )