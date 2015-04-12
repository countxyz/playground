class ImageEditor.app

  'use strict'

  helper = ImageEditor.helper

  resizeableImage: (imageTarget) ->
    $container    = undefined
    orig_src      = new Image
    imageTarget   = $(imageTarget).get(0)
    eventState    = {}
    constrain     = false
    min_width     = 60
    min_height    = 60
    max_width     = 800
    max_height    = 900
    resize_canvas = document.createElement('canvas')

    init = ->
      orig_src.src = imageTarget.src
      helper.resizeHandles(imageTarget)
      $container = $(imageTarget).parent('.resize-container')
      $container.on 'mousedown touchstart', '.resize-handle', startResize
      $container.on 'mousedown touchstart', 'img', startMoving
      $('.js-crop').on 'click', crop

    startResize = (e) ->
      e.preventDefault()
      e.stopPropagation()
      helper.saveEventState e, eventState, $container
      $(document).on 'mousemove touchmove', resizing
      $(document).on 'mouseup touchend', endResize

    endResize = (e) ->
      e.preventDefault()
      $(document).off 'mouseup touchend', endResize
      $(document).off 'mousemove touchmove', resizing

    resizing = (e) ->
      mouse   = {}
      offset  = $container.offset()
      resizingMouseCoordinates e, mouse

      if $(eventState.evnt.target).hasClass 'resize-handle-se'
        width  = mouse.x - eventState.container_left
        height = mouse.y - eventState.container_top
        left   = eventState.container_left
        top    = eventState.container_top

      else if $(eventState.evnt.target).hasClass 'resize-handle-sw'
        width  = eventState.container_width - (mouse.x - eventState.container_left)
        height = mouse.y - eventState.container_top
        left   = mouse.x
        top    = eventState.container_top

      else if $(eventState.evnt.target).hasClass 'resize-handle-nw'
        width  = eventState.container_width - (mouse.x - eventState.container_left)
        height = eventState.container_height - (mouse.y - eventState.container_top)
        left   = mouse.x
        top    = mouse.y
        if constrain || e.shiftKey
          top = mouse.y - (width / orig_src.width * orig_src.height - height)

      else if $(eventState.evnt.target).hasClass 'resize-handle-ne'
        width  = mouse.x - eventState.container_left
        height = eventState.container_height - (mouse.y - eventState.container_top)
        left   = eventState.container_left
        top    = mouse.y
        if constrain || e.shiftKey
          top = mouse.y - (width / orig_src.width * orig_src.height - height)

      if constrain || e.shiftKey
        height = width / orig_src.width * orig_src.height

      if width > min_width && height > min_height && width < max_width && height < max_height
        resizeImage width, height
        $container.offset { 'left': left, 'top': top }

    resizeImage = (width, height) ->
      resize_canvas.width  = width
      resize_canvas.height = height
      resize_canvas.getContext('2d').drawImage orig_src, 0, 0, width, height
      $(imageTarget).attr 'src', resize_canvas.toDataURL('image/png')

    startMoving = (e) ->
      e.preventDefault()
      e.stopPropagation()
      helper.saveEventState e, eventState, $container
      $(document).on 'mousemove touchmove', moving
      $(document).on 'mouseup touchend', endMoving

    endMoving = (e) ->
      e.preventDefault()
      $(document).off 'mouseup touchend', endMoving
      $(document).off 'mousemove touchmove', moving

    moving = (e) ->
      mouse = {}
      e.preventDefault()
      e.stopPropagation()
      touches = e.originalEvent.touches

      movingMouseCoordinates e, mouse, touches

      $container.offset
        'left': mouse.x - (eventState.mouse_x - eventState.container_left)
        'top': mouse.y - (eventState.mouse_y - eventState.container_top)

      if eventState.touches && eventState.touches.length > 1 && touches.length > 1
        width  = eventState.container_width
        height = eventState.container_height

        eventClientX  = Math.sqrt helper.eventXTouchDiff eventState
        eventClientY  = Math.sqrt helper.eventYTouchDiff eventState
        eventDistance = Math.sqrt eventClientX + eventClientY

        ogEventClientX  = Math.sqrt helper.ogEventXTouch e, eventState
        ogEventClientY  = Math.sqrt helper.ogEventYTouch e, eventState
        ogEventDistance = Math.sqrt ogEventClientX + ogEventClientY

        ratio  = helper.distanceRatio ogEventDistance, eventDistance
        width  = helper.resizeWidth width, ratio
        height = helper.resizeHeight height, ratio

        resizeImage width, height

    resizingMouseCoordinates = (e, mouse) ->
      mouse.x = (e.clientX || e.pageX || e.originalEvent.touches[0].clientX) +
        $(window).scrollLeft()

      mouse.y = (e.clientY || e.pageY || e.originalEvent.touches[0].clientY) +
        $(window).scrollTop()

    movingMouseCoordinates = (e, mouse, touches) ->
      mouse.x = (e.clientX || e.pageX || touches[0].clientX) + $(window).scrollLeft()
      mouse.y = (e.clientY || e.pageY || touches[0].clientY) + $(window).scrollTop()

    crop = ->
      left   = $('.overlay').offset().left - $container.offset().left
      top    = $('.overlay').offset().top - $container.offset().top
      width  = $('.overlay').width()
      height = $('.overlay').height()

      crop_canvas        = document.createElement('canvas')
      crop_canvas.width  = width
      crop_canvas.height = height

      crop_canvas.getContext('2d')
        .drawImage imageTarget, left, top, width, height, 0, 0, width, height

      window.open crop_canvas.toDataURL 'image/png'

    init()

image = new ImageEditor.app
image.resizeableImage $('.resize-image')
