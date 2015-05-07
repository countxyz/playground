'use strict'

do (window) ->

  extend = (a, b) ->
    for key of b
      if b.hasOwnProperty(key)
        a[key] = b[key]
    a

  DialogFx = (el, options) ->
    @el = el
    @options = extend({}, @options)
    extend @options, options
    @ctrlClose = @el.querySelector('[data-dialog-close]')
    @isOpen = false
    @_initEvents()

  support = animations: Modernizr.cssanimations
  animEndEventNames =
    'WebkitAnimation': 'webkitAnimationEnd'
    'OAnimation': 'oAnimationEnd'
    'msAnimation': 'MSAnimationEnd'
    'animation': 'animationend'
  animEndEventName = animEndEventNames[Modernizr.prefixed('animation')]

  onEndAnimation = (el, callback) ->

    onEndCallbackFn = (ev) ->
      if support.animations
        if ev.target != this then return
        @removeEventListener animEndEventName, onEndCallbackFn
      if callback && typeof callback == 'function' then callback.call()

    if support.animations
      el.addEventListener animEndEventName, onEndCallbackFn
    else
      onEndCallbackFn()

  DialogFx::options =
    onOpenDialog:  -> false
    onCloseDialog: -> false

  DialogFx::_initEvents = ->
    self = this
    @ctrlClose.addEventListener 'click', @toggle.bind(this)
    document.addEventListener 'keydown', (ev) ->
      keyCode = ev.keyCode || ev.which
      if keyCode == 27 && self.isOpen
        self.toggle()
    @el.querySelector('.dialog__overlay').addEventListener 'click', @toggle.bind(this)

  DialogFx::toggle = ->
    self = this
    if @isOpen
      classie.remove @el, 'dialog--open'
      classie.add self.el, 'dialog--close'
      onEndAnimation @el.querySelector('.dialog__content'), ->
        classie.remove self.el, 'dialog--close'
      @options.onCloseDialog this
    else
      classie.add @el, 'dialog--open'
      @options.onOpenDialog this
    @isOpen = !@isOpen

  window.DialogFx = DialogFx
