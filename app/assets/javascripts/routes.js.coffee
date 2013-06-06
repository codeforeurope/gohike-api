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

  $(".waypoint-info").popover()

  $rewardModal = $("#reward_modal")
  $rewardBox = $(".reward-box")

  $rewardBox.find(".btn-danger").unbind("ajax:success").on 'ajax:success', (data, textStatus, jqXHR)->
    $rewardBox.load(window.location.href + "/reward", null, afterRewardRefresh)

  attachSuccessCallback = ()->
    $rewardModal.find('form').unbind("ajax:success").on "ajax:success", (xhr, data, status)->
      url = window.location.href + "/reward"
      console.log(url);
      $rewardBox.load(url, null, afterRewardRefresh)
      $rewardModal.modal "hide"


  afterRewardRefresh = ()->
#    $rewardModal.modal()
    fixLoad()
    $rewardBox.find(".btn-danger").unbind("ajax:success").on 'ajax:success', (data, textStatus, jqXHR)->
      $rewardBox.load(window.location.href + "/reward", null, afterRewardRefresh)


  attachErrorCallback = ()->
    $rewardModal.find('form').unbind("ajax:error").on "ajax:error", (xhr, data, status)->
      $rewardModal.find('.modal-body').html data.responseText
      attachSuccessCallback()
      attachErrorCallback()

  $rewardModal.find("button.save").on 'click', (e)->
    $rewardModal.find(".modal-body form").trigger("submit")

  $rewardModal.on 'shown', (e)->
    attachSuccessCallback()
    attachErrorCallback()
    $rewardModal.find(".modal-body form input[id*=rewardable_id]").val($rewardModal.data("rewardable-id"))
    $rewardModal.find(".modal-body form input[id*=rewardable_type]").val($rewardModal.data("rewardable-type"))


  fixLoad = ()->
    $('a[data-toggle="modal"]').unbind('click').on 'click', () ->
      $rewardModal.find('#modal_title').html $(this).html()
      $rewardModal.find('.modal-body').load $(this).attr('href'), null, (response, status, xhr)->
        if (status == 'error')
          $rewardModal.find('.modal-body').html('<h2>Oh boy</h2><p>Sorry, but there was an error:' + xhr.status + ' ' + xhr.statusText + '</p>')
      return true




