window.ContextMenu ?= {}

ContextMenu.helper = {

  clickInsideElement: (e, className) ->
    el = e.srcElement || e.target
    if el.classList.contains(className)
      return el
    else
      while el = el.parentNode
        if el.classList && el.classList.contains(className)
          return el

    false

  getPosition: (e) ->
    posx = 0
    posy = 0

    if !e
      e = window.event
    if e.pageX || e.pageY
      posx = e.pageX
      posy = e.pageY
    else if e.clientX || e.clientY
      posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
      posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
    { x: posx, y: posy }
}
