class Soulmate.app
  'use strict'

  helper = Soulmate.helper

  constructor: (@input, options) ->
    that = this

    {url, types, renderCallback, selectCallback, maxResults, minQueryLength,
    timeout} = options

    @url        = url
    @types      = types
    @maxResults = maxResults
    @timeout    = timeout || 500
    @xhr        = null

    @suggestions = new Soulmate.suggestionCollection renderCallback, selectCallback
    @query       = new Soulmate.query minQueryLength

    @determineSoulmateContainer()

    @container.delegate '.soulmate-suggestion',
      mouseover: -> that.suggestions.focusElement @
      click: (event) ->
        event.preventDefault()
        that.suggestions.selectFocused()
        that.input.focus()

    @input.keydown(@handleKeydown).keyup(@handleKeyup).
      mouseover(-> that.suggestions.blurAll())

  determineSoulmateContainer: ->
    if $('ul#soulmate').length > 0
      @container = $('ul#soulmate')
    else
      @container = $('<ul id="soulmate">').insertAfter @input

  handleKeydown: (event) =>
    killEvent = true

    switch helper.KEYCODES[event.keyCode]

      when 'escape' then @hideContainer()
      when 'tab'    then @suggestions.selectFocused()
      when 'up'     then @suggestions.focusPrevious()
      when 'down'   then @suggestions.focusNext()

      when 'enter'
        @suggestions.selectFocused()
        if @suggestions.allBlured() then killEvent = false

      else killEvent = false

    if killEvent
      event.stopImmediatePropagation()
      event.preventDefault()

  handleKeyup: (event) =>
    @query.setValue @input.val()
    if @query.hasChanged() then @updateContainer()

  updateContainer: ->
    if @query.willHaveResults()
      @suggestions.blurAll()
      @fetchResults()
    else
      @hideContainer()

  hideContainer: ->
    @suggestions.blurAll()
    @container.hide()
    $(document).unbind 'click.soulmate'

  showContainer: ->
    @container.show()
    $(document).bind 'click.soulmate', (event) =>
      @hideContainer() unless @container.has($(event.target)).length

  fetchResults: ->
    @xhr.abort() if @xhr?

    @xhr = $.ajax({
      url: @url
      dataType: 'jsonp'
      timeout: @timeout
      cache: true
      data: { term: @query.getValue(), types: @types, limit: @maxResults }
      success: (data) => @update( data.results ) })

  update: (results) ->
    @suggestions.update results

    if @suggestions.count() > 0
      @container.html( $(@suggestions.render()) )
      @showContainer()
    else
      @query.markEmpty()
      @hideContainer()

$.fn.soulmate = (options) ->
  new Soulmate.app $(@), options
  $(@)
