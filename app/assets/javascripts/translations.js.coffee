# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onAddTranslation = (e)->
  $locale_button = $(this)
  locale = $locale_button.data('locale')
  $tabs = $($locale_button.parents()[4])
  $tabContents = $tabs.parent().find(".tab-content")

  $.get $locale_button.data("translation-url") + locale, (data, xhr, status) ->
#
    $tabs.find('li.active').removeClass('active')
    $tabContents.find('div.active').removeClass('active').removeClass('in')


    $(data).find("[data-toggle=tab]").parent().insertBefore($tabs.children().last())


    $tabContents.append($(data).find(".tab-pane"))
    $tabs.find('a[data-toggle=tab]:last').tab('show')
    $list = $locale_button.parent().parent()
    $locale_button.parent().remove()
    if $list.children().length == 0
      $tabs.children().last().hide()



jQuery ->
  $(".add-translation").parent().find(".dropdown-menu a").on "click", onAddTranslation


