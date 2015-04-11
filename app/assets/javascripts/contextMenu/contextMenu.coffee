class ContextMenu.app

  'use strict'

  helper = ContextMenu.helper

  contextMenuActive        = 'context-menu-active'
  contextMenuClassName     = 'context-menu-interface'
  contextMenuItemClassName = 'context-menu-item'
  contextMenuLinkClassName = 'context-menu-link'

  menu      = document.querySelector('#context-menu')
  menuItems = menu.querySelectorAll('.context-menu-item')
  menuState = 0

  taskItemClassName = 'task'

  init: ->
    contextListener()
    clickListener()
    keyupListener()
    resizeListener()

  contextListener = ->
    document.addEventListener 'contextmenu', (e) ->
      taskItemInContext = helper.clickInsideElement e, taskItemClassName

      if taskItemInContext
        e.preventDefault()
        toggleMenuOn()
        positionMenu e
      else
        taskItemInContext = null
        toggleMenuOff()

  clickListener = ->
    document.addEventListener 'click', (e) ->
      clickeElIsLink = helper.clickInsideElement e, contextMenuLinkClassName

      if clickeElIsLink
        e.preventDefault()
        menuItemListener clickeElIsLink
      else
        button = e.which || e.button
        if button == 1 then toggleMenuOff()

  keyupListener = ->
    window.onkeyup = (e) -> if e.keyCode == 27 then toggleMenuOff()

  resizeListener = ->
    window.onresize = (e) -> toggleMenuOff()

  toggleMenuOn = ->
    if menuState != 1
      menuState = 1
      menu.classList.add contextMenuActive

  toggleMenuOff = ->
    if menuState != 0
      menuState = 0
      menu.classList.remove contextMenuActive

  positionMenu = (e) ->
    clickCoords  = helper.getPosition e
    clickCoordsX = clickCoords.x
    clickCoordsY = clickCoords.y
    menuWidth    = menu.offsetWidth + 4
    menuHeight   = menu.offsetHeight + 4
    windowWidth  = window.innerWidth
    windowHeight = window.innerHeight

    if windowWidth - clickCoordsX < menuWidth
      menu.style.left = windowWidth - menuWidth + 'px'
    else
      menu.style.left = clickCoordsX + 'px'

    if windowHeight - clickCoordsY < menuHeight
      menu.style.top = windowHeight - menuHeight + 'px'
    else
      menu.style.top = clickCoordsY + 'px'

  menuItemListener = (link) ->
    console.log 'Task ID - ' +
      taskItemInContext.getAttribute('data-id') +
      ', Task action - ' +
      link.getAttribute 'data-action'

    toggleMenuOff()

contextMenu = new ContextMenu.app
contextMenu.init()
