# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
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
    $rewardModal.find(".modal-body .add-translation").parent().find(".dropdown-menu a").unbind("click").on "click", onAddTranslation


  fixLoad = ()->
    $('a[data-toggle="modal"]').unbind('click').on 'click', () ->
      $rewardModal.find('#modal_title').html $(this).html()
      $rewardModal.find('.modal-body').load $(this).attr('href'), null, (response, status, xhr)->
        if (status == 'error')
          $rewardModal.find('.modal-body').html('<h2>Oh boy</h2><p>Sorry, but there was an error:' + xhr.status + ' ' + xhr.statusText + '</p>')
      return true


  $("#route_city_id").change (e)->
    $select_wrapper = $(this).parent().parent().next()
    $select_controls = $select_wrapper.find("select")
    city_id = $(this).val()
    url = "/route_profiles/in_cities?city_ids=#{city_id}"
    $select_controls.load url, (data, xhr, status)->
      $select_wrapper.removeClass("hidden")

  if $("#new_route").length > 0
    $("#route_city_id").trigger "change"


  $(document).on 'ajax:success', "#route_details .publish, #route_details .unpublish", (xhr, data, status)->
    $("#route_details").replaceWith(data)