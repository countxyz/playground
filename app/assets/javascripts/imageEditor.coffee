class window.ImageEditor

  constructor: (@minWidth, @minHeight, @maxWidth, @maxHeight, imageTarget) ->
    @imageTarget  = $(imageTarget)
    @container    = $(imageTarget).parent '.resize-container'
    @ogSrc        = new Image
    @ogSrc.src    = @imageTarget[0].src
    @eventState   = {}
    @constrain    = false
    @resizeCanvas = document.createElement 'canvas'

    @_imageHandles()
    @_startMouseActions()
    @_clickButtonCrop()

  _imageHandles: ->
    @imageTarget.wrap('<div class="resize-container"></div>')
      .before '<span class="resize-handle resize-handle-nw"></span>'
      .before '<span class="resize-handle resize-handle-ne"></span>'
      .after '<span class="resize-handle resize-handle-se"></span>'
      .after '<span class="resize-handle resize-handle-sw"></span>'

  _startMouseActions: ->
    @container.on 'mousedown touchstart', '.resize-handle', (event) ->
      @_startResize()
    @container.on 'mousedown touchstart', 'img', (event) -> @_startMoving()

  _clickButtonCrop: -> $('.js-crop').on 'click', (event) -> @_crop()

  _startResize: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @_saveEventState e
    $(document).on 'mousemove touchmove', @_resizing()
    $(document).on 'mouseup touchend',    @_endResize()

  _endResize: (e) ->
    e.preventDefault()
    $(document).off 'mouseup touchend',    @_endResize()
    $(document).off 'mousemove touchmove', @_resizing()

  _saveEventState: (e) ->
    @eventState.container_width  = @container.width()
    @eventState.container_height = @container.height()
    @eventState.container_left   = @container.offset().left
    @eventState.container_top    = @container.offset().top

    @eventState.mouse_x =
      (e.clientX || e.pageX || e.originalEvent.touches[0].clientX) +
      $(window).scrollLeft()
    @eventState.mouse_y =
      (e.clientY || e.pageY || e.originalEvent.touches[0].clientY) +
      $(window).scrollTop()

    if typeof e.originalEvent.touches != 'undefined'
      @eventState.touches = []
      $.each e.originalEvent.touches, (i, ob) ->
        @eventState.touches[i] = {}
        @eventState.touches[i].clientX = 0 + ob.clientX
        @eventState.touches[i].clientY = 0 + ob.clientY

    @eventState.evnt = e

  _resizing: (e) ->
    mouse  = {}
    offset = @container.offset()

    mouse.x =
      (e.clientX || e.pageX || e.originalEvent.touches[0].clientX) +
      $(window).scrollLeft()
    mouse.y =
      (e.clientY || e.pageY || e.originalEvent.touches[0].clientY) +
      $(window).scrollTop()

    if @eventState.evnt.target.hasClass 'resize-handle-se'
      width  = mouse.x - @eventState.container_left
      height = mouse.y - @eventState.container_top
      left   = @eventState.container_left
      top    = @eventState.container_top

    else if @eventState.evnt.target.hasClass 'resize-handle-sw'
      width  = @eventState.container_width - (mouse.x - @eventState.container_left)
      height = mouse.y - @eventState.container_top
      left   = mouse.x
      top    = @eventState.container_top

    else if @eventState.evnt.target.hasClass 'resize-handle-nw'
      width  = @eventState.container_width  - (mouse.x - @eventState.container_left)
      height = @eventState.container_height - (mouse.y - @eventState.container_top)
      left   = mouse.x
      top    = mouse.y

      if @constrain || e.shiftKey
        top = mouse.y - ((width / @ogSrc.width * @ogSrc.height) - height)

    else if @eventState.evnt.target.hasClass 'resize-handle-ne'
      width  = mouse.x - @eventState.container_left
      height = @eventState.container_height - (mouse.y - @eventState.container_top)
      left   = @eventState.container_left
      top = mouse.y
      if @constrain || e.shiftKey
        top = mouse.y - ((width / @ogSrc.width * @ogSrc.height) - height)

    if @constrain || e.shiftKey
      height = width / @ogSrc.width * @ogSrc.height

    if width > @minWidth && height > @minHeight && width < @maxWidth && height < @maxHeight
      @_resizeImage width, height
      @container.offset {'left': left, 'top': top}

  _resizeImage: (width, height) ->
    @resizeCanvas.width  = width
    @resizeCanvas.height = height
    @resizeCanvas.getContext('2d').drawImage @ogSrc, 0, 0, width, height
    @imageTarget.attr 'src', @resizeCanvas.toDataURL 'image/png'

  _startMoving: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @_saveEventState e
    $(document).on 'mousemove touchmove', @_moving()
    $(document).on 'mouseup touchend',    @_endMoving()

  _endMoving: (e) ->
    e.preventDefault()
    $(document).off 'mouseup touchend',    @_endMoving()
    $(document).off 'mousemove touchmove', @_moving()

  _moving: (e) ->
    mouse = {}
    e.preventDefault()
    e.stopPropagation()

    touches = e.originalEvent.touches

    mouse.x =
      (e.clientX || e.pageX || touches[0].clientX) + $(window).scrollLeft()
    mouse.y =
      (e.clientY || e.pageY || touches[0].clientY) + $(window).scrollTop()

    $container.offset
      'left': mouse.x - ( @eventState.mouse_x - @eventState.container_left )
      'top' : mouse.y - ( @eventState.mouse_y - @eventState.container_top )

    if @eventState.touches && @eventState.touches.length > 1 && touches.length > 1
      width  = @eventState.container_width
      height = @eventState.container_height
      a = @eventState.touches[0].clientX - @eventState.touches[1].clientX
      a *= a
      b = @eventState.touches[0].clientY - @eventState.touches[1].clientY
      b *= b
      dist1 = Math.sqrt( a + b )

      a = e.originalEvent.touches[0].clientX - touches[1].clientX
      a *= a
      b = e.originalEvent.touches[0].clientY - touches[1].clientY
      b *= b
      dist2 = Math.sqrt( a + b )

      ratio = dist2 / dist1

      width  *= ratio
      height *= ratio

      @_resizeImage width, height

  _crop: ->
    console.log @container
    left   = $('.overlay').offset().left - @container.offset().left
    top    = $('.overlay').offset().top  - @container.offset().top
    width  = $('.overlay').width()
    height = $('.overlay').height()

    cropCanvas        = document.createElement 'canvas'
    cropCanvas.width  = width
    cropCanvas.height = height

    cropCanvas.getContext('2d')
      .drawImage @imageTarget, left, top, width, height, 0, 0, width, height

    window.open cropCanvas.toDataURL 'image/png'

imageEditor = new ImageEditor 60, 60, 800, 900, $('.resize-image')
