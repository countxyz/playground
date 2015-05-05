class Soulmate.suggestion
  'use strict'

  constructor: (index, @term, @data, @type) ->
    @id    = "#{index}-soulmate-suggestion"
    @index = index

  select: (callback) -> callback( @term, @data, @type, @index, @id)

  focus: -> @element().addClass( 'focus' )

  blur: -> @element().removeClass( 'focus' )

  render: (callback) ->
    """
      <li id="#{@id}" class="soulmate-suggestion">
        #{callback( @term, @data, @type, @index, @id)}
      </li>
    """

  element: -> $('#' + @id)
