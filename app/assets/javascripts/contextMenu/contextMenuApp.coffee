class ContextMenu.app

  'use strict'

  helper = ContextMenu.helper

  contextMenuActive        = 'context-menu-active'
  contextMenuClassName     = 'context-menu-interface'
  contextMenuItemClassName = 'context-menu-item'
  contextMenuLinkClassName = 'context-menu-link'

  itemClassName = 'task'

  menu      = document.querySelector '#context-menu'
  menuItems = menu.querySelectorAll '.context-menu-item'
  menuState = 0

  init: ->
    contextListener()
    clickListener()
    keyupListener()
    resizeListener()

  contextListener = ->
    document.addEventListener 'contextmenu', (e) =>
      contextItem = helper.clickInsideElement e, itemClassName

      if contextItem
        e.preventDefault()
        toggleMenuOn()
        positionMenu e
      else
        contextItem = null
        toggleMenuOff()

  clickListener = ->
    document.addEventListener 'click', (e) ->
      clickeElIsLink = helper.clickInsideElement e, contextMenuLinkClassName

      if clickeElIsLink
        e.preventDefault()
        menuItemListener clickeElIsLink
      else
        ensureLeftClick e

  keyupListener = ->
    window.onkeyup = (e) -> if e.keyCode == 27 then toggleMenuOff()

  menuItemListener = (link) ->
    console.log 'Task ID - ' +
      taskItemInContext.getAttribute('data-id') +
      ', Task action - ' +
      link.getAttribute 'data-action'

    toggleMenuOff()

  resizeListener = ->
    window.onresize = (e) -> toggleMenuOff()

  toggleMenuOn = -> displayMenu() if menuStateOff()

  toggleMenuOff = -> hideMenu() if menuStateOn()

  menuStateOn = -> menuState != 0

  menuStateOff = -> menuState != 1

  displayMenu = ->
    menuState = 1
    menu.classList.add contextMenuActive

  hideMenu = ->
    menuState = 0
    menu.classList.remove contextMenuActive

  positionMenu = (e) ->
    clickCoords  = helper.getPosition e
    styleMenuLeft clickCoords
    styleMenuTop clickCoords

  styleMenuLeft = (clickCoords) ->
    menuWidth = menu.offsetWidth + 4

    if window.innerWidth - clickCoords.x < menuWidth
      menu.style.left = window.innerWidth - menuWidth + 'px'
    else
      menu.style.left = clickCoords.x + 'px'

  styleMenuTop = (clickCoords) ->
    menuHeight = menu.offsetHeight + 4

    if window.innerWidth - clickCoords.y < menuHeight
      menu.style.top = window.innerHeight - menuHeight + 'px'
    else
      menu.style.top = clickCoords.y + 'px'

  ensureLeftClick = (e) ->
    button = e.which || e.button
    if button == 1 then toggleMenuOff()

contextMenu = new ContextMenu.app
contextMenu.init()
