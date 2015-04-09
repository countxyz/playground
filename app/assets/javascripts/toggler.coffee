class window.Toggler

  constructor: (toggleLinks) ->
    @toggleLinks = $(toggleLinks)

    @_toggle()

  _toggle: ->
    @toggleLinks.click (event) ->
      $detail = $(@).siblings '.detail'

      if $detail.hasClass 'hidden'
        $(@).text 'Hide Details'
      else
        $(@).text 'Show Details'

      $detail.toggleClass 'hidden'
      event.preventDefault()

toggler = new Toggler $('.detail-toggle')
