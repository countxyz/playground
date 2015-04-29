ready = ->

  render = (term, data, type) -> term

  select = (term, data, type) ->
    $('#search').val term
    $('ul#soulmate').hide()
    window.location.href = data.link

  $('#search').soulmate
    url: '/autocomplete/search'
    types: [ 'accounts', 'contacts' ]
    renderCallback: render
    selectCallback: select
    minQueryLength: 2
    maxResults: 5

$(document).ready ready
