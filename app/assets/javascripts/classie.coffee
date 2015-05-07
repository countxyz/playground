'use strict'

do (window) ->

  classReg = (className) -> new RegExp('(^|\\s+)' + className + '(\\s+|$)')

  toggleClass = (elem, c) ->
    fn = if hasClass(elem, c) then removeClass else addClass
    fn elem, c

  if 'classList' of document.documentElement
    hasClass    = (elem, c) -> elem.classList.contains c
    addClass    = (elem, c) -> elem.classList.add c
    removeClass = (elem, c) -> elem.classList.remove c
  else
    hasClass = (elem, c) -> classReg(c).test elem.className
    addClass = (elem, c) ->
      if !hasClass(elem, c) then elem.className = elem.className + ' ' + c
    removeClass = (elem, c) ->
      elem.className = elem.className.replace(classReg(c), ' ')

  classie =
    hasClass: hasClass
    addClass: addClass

    removeClass: removeClass
    toggleClass: toggleClass

    has: hasClass
    add: addClass

    remove: removeClass
    toggle: toggleClass

  if typeof define == 'function' && define.amd
    define classie
  else
    window.classie = classie
