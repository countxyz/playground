class Soulmate.suggestionCollection
  'use strict'

  constructor: (@renderCallback, @selectCallback) ->
    @focusedIndex = -1
    @suggestions  = []

  update: (results) ->
    @suggestions = []
    i = 0

    for type, typeResults of results
      for result in typeResults
        @suggestions.push(
          new Soulmate.suggestion(i, result.term, result.data, type) )
        i += 1

  blurAll: ->
    @focusedIndex = -1
    suggestion.blur() for suggestion in @suggestions

  render: ->
    h = ''

    if @suggestions.length
      type = null

      for suggestion in @suggestions
        if suggestion.type != type
          h += @_renderTypeEnd(type) unless type == null
          type = suggestion.type
          h += @_renderTypeStart()

        h += @_renderSuggestion suggestion

      h += @_renderTypeEnd type

    return h

  count: -> @suggestions.length

  focus: (i) ->
    if i < @count()
      @blurAll()

      if i < 0
        @focusedIndex = -1

      else
        @suggestions[i].focus()
        @focusedIndex = i

  focusElement: (element) ->
    index = parseInt $(element).attr('id')
    @focus index

  focusNext: -> @focus @focusedIndex + 1

  focusPrevious: -> @focus @focusedIndex - 1

  selectFocused: ->
    if @focusedIndex >= 0
      @suggestions[@focusedIndex].select @selectCallback

  allBlured: -> @focusedIndex == -1

  _renderTypeStart: ->
    """
      <li class="soulmate-type-container">
        <ul class="soulmate-type-suggestions">
    """

  _renderTypeEnd: (type) ->
    """
        </ul>
        <div class="soulmate-type">#{type}</div>
      </li>
    """

  _renderSuggestion: (suggestion) -> suggestion.render @renderCallback
