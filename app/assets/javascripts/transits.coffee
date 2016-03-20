# grab next times when this one runs out
# refresh page using new time when timer reaches 0

# var d = new Date($("[data-behavior='timer']").data("stoptimes")[0])
# $("[data-behavior='timer']").countdown({until: d, format: "HMS"});

ready = ->
  $("[data-behavior='timer']").each ->
    next_stoptime = new Date($(this).data('stoptimes')[0])
    $(this).countdown({until: next_stoptime})

$(document).ready(ready)
$(document).on("turbolinks:load", ready)
