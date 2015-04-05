window.Toggler = class Toggler

  init: ->
    $toggle_links = $('.detail-toggle')
    $toggle_links.click (event) ->
      $detail = $(this).siblings('.detail')
      $detail.toggleClass 'hidden'
      event.preventDefault()

toggler = new Toggler
toggler.init()
