window.Toggler = class Toggler

  init: ->
    $toggle_links = $('.detail-toggle')

    $toggle_links.click (event) ->
      $detail = $(this).siblings '.detail'

      if $detail.hasClass 'hidden'
        $(this).text 'Hide Details'
      else
        $(this).text 'Show Details'

      $detail.toggleClass 'hidden'
      event.preventDefault()

toggler = new Toggler
toggler.init()
