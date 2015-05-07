'use strict'

window.ImageEditor ?= {}

ImageEditor.helper = {

  resizeHandles: (element) ->
    $(element).wrap('<div class="resize-container"></div>')
      .before('<span class="resize-handle resize-handle-nw"></span>')
      .before('<span class="resize-handle resize-handle-ne"></span>')
      .after('<span class="resize-handle resize-handle-se"></span>')
      .after '<span class="resize-handle resize-handle-sw"></span>'

  saveEventState: (e, eventState, element) ->
    @.measureEventState eventState, element
    eventState.mouse_x = @.xMouseState e
    eventState.mouse_y = @.yMouseState e
    @.saveEventTouches(e, eventState) if e.originalEvent.touches?
    eventState.evnt = e

  measureEventState: (eventState, element) ->
    eventState.container_width  = element.width()
    eventState.container_height = element.height()
    eventState.container_left   = element.offset().left
    eventState.container_top    = element.offset().top

  xMouseState: (e) ->
    (e.clientX || e.pageX || e.originalEvent.touches[0].clientX) +
      $(window).scrollLeft()

  yMouseState: (e) ->
    (e.clientY || e.pageY || e.originalEvent.touches[0].clientY) +
      $(window).scrollTop()

  saveEventTouches: (e, eventState) ->
    eventState.touches = []

    $.each e.originalEvent.touches, (i, ob) ->
      eventState.touches[i] = {}
      eventState.touches[i].clientX = 0 + ob.clientX
      eventState.touches[i].clientY = 0 + ob.clientY

  eventXTouchDiff: (eventState) ->
    eventState.touches[0].clientX - eventState.touches[1].clientX

  eventYTouchDiff: (eventState) ->
    eventState.touches[0].clientY - eventState.touches[1].clientY

  ogEventXTouch: (e, eventState) ->
    e.originalEvent.touches[0].clientX - touches[1].clientX

  ogEventYTouch: (e, eventState) ->
    e.originalEvent.touches[0].clientY - touches[1].clientY

  distanceRatio: (distanceB, distanceA) -> distanceB / distanceA

  resizeWidth: (width, ratio) -> width * ratio

  resizeHeight: (height, ratio) -> height * ratio
}
