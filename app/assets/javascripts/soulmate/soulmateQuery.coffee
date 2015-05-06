class Soulmate.query
  'use strict'

  constructor: (@minLength) ->
    @value       = ''
    @lastValue   = ''
    @emptyValues = []

  getValue: -> @value

  setValue: (newValue) ->
    @lastValue = @value
    @value     = newValue

  hasChanged: -> !(@value == @lastValue)

  markEmpty: -> @emptyValues.push @value

  willHaveResults: -> @_isValid() && !@_isEmpty()

  _isValid: -> @value.length >= @minLength

  _isEmpty: ->
    for empty in @emptyValues
      true if @value[0...empty.length] == empty
    false
