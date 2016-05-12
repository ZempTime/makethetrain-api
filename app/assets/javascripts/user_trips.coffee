class UserTrip
  constructor: (item) ->
    @item = $(item)
    @segments = $.map @item.find("[data-behavior='segment']"), (item, i) ->
      new Segment(item)

class Segment
  constructor: (item) ->
    @item = $(item)
    @timer = @item.find($("[data-behavior='timer']"))
    @activateTimer()

  activateTimer: =>
    next_stoptime = new Date($(@timer).data('stoptime'))
    @timer.countdown next_stoptime, (event) ->
      $(this).text event.strftime('%H:%M:%S')

document.addEventListener 'turbolinks:load', ->
  new UserTrip $("[data-behavior='user-trip']")
