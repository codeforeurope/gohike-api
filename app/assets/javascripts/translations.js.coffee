# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $translationButton = $(".add-translation")

  $translationButton.on "click", (e) ->
    $new_locale = $("#new_locale")
    locale = $new_locale.val()
    $tabs = $(this).parent().parent()
    $tabContents = $(".tab-content")

    $.get $(this).data("translation-url") + locale, (data, xhr, status) ->
#      console.log(data, xhr, status)
      $tabs.find('li.active').removeClass('active')
      $tabContents.find('div.active').removeClass('active').removeClass('in')


      $(data).find("[data-toggle=tab]").parent().insertBefore($tabs.children().last().prev())


      $tabContents.append($(data).find(".tab-pane"))
      $tabs.find('a:last').parent().find('a').tab('show')
      selectedIndex = $new_locale.prop("selectedIndex")
      new_options = ""
      $new_locale.find("option").each (i, o)->
        if i != $new_locale.prop("selectedIndex")
          new_options = new_options + o.outerHTML
      $new_locale.empty().html(new_options)

