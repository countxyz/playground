(function() {

  'use strict';

  function clickInsideElement(e, className) {
    var el = e.srcElement || e.target;

    if (el.classList.contains(className)) {
      return el;
    }
    else {
      while (el = el.parentNode) {
        if (el.classList && el.classList.contains(className)) {
          return el;
        }
      }
    }
    return false;
  }

  function getPosition(e) {
    var
      posx = 0,
      posy = 0;

    if (!e) var e = window.event;

    if (e.pageX || e.pageY) {
      posx = e.pageX;
      posy = e.pageY;
    }
    else if (e.clientX || e.clientY) {
      posx = e.clientX + document.body.scrollLeft +
        document.documentElement.scrollLeft;
      posy = e.clientY + document.body.scrollTop +
        document.documentElement.scrollTop;
    }
    return {x: posx, y: posy}
  }

  var
    clickCoords,
    clickCoordsX,
    clickCoordsY,
    contextMenuActive        = 'context-menu-active',
    contextMenuClassName     = 'context-menu-interface',
    contextMenuItemClassName = 'context-menu-item',
    contextMenuLinkClassName = 'context-menu-link',

    menu = document.querySelector('#context-menu'),
    menuHeight,
    menuItems = menu.querySelectorAll('.context-menu-item'),
    menuPosition,
    menuPositionX,
    menuPositionY,
    menuState = 0,
    menuWidth,

    taskItemClassName = 'task',
    taskItemInContext,

    windowHeight,
    windowWidth;

  function init() {
    contextListener();
    clickListener();
    keyupListener();
    resizeListener();
  }

  function contextListener() {
    document.addEventListener('contextmenu',
      function(e) {
        taskItemInContext = clickInsideElement(e, taskItemClassName);

        if ( taskItemInContext ) {
          e.preventDefault();
          toggleMenuOn();
          positionMenu(e);
        }
        else {
          taskItemInContext = null;
          toggleMenuOff();
        }
      }
    );
  }

  function clickListener() {
    document.addEventListener('click',
      function(e) {
        var clickeElIsLink = clickInsideElement(e, contextMenuLinkClassName);

        if ( clickeElIsLink ) {
          e.preventDefault();
          menuItemListener( clickeElIsLink );
        }
        else {
          var button = e.which || e.button;
          if ( button === 1 ) {
            toggleMenuOff();
          }
        }
      }
    );
  }

  function keyupListener() {
    window.onkeyup = function(e) {
      if (e.keyCode === 27) {
        toggleMenuOff();
      }
    }
  }

  function resizeListener() {
    window.onresize = function(e) {
      toggleMenuOff();
    };
  }

  function toggleMenuOn() {
    if ( menuState !== 1 ) {
      menuState = 1;
      menu.classList.add(contextMenuActive);
    }
  }

  function toggleMenuOff() {
    if (menuState !== 0) {
      menuState = 0;
      menu.classList.remove(contextMenuActive);
    }
  }

  function positionMenu(e) {
    clickCoords  = getPosition(e);
    clickCoordsX = clickCoords.x;
    clickCoordsY = clickCoords.y;

    menuWidth  = menu.offsetWidth + 4;
    menuHeight = menu.offsetHeight + 4;

    windowWidth = window.innerWidth;
    windowHeight = window.innerHeight;

    if ((windowWidth - clickCoordsX) < menuWidth) {
      menu.style.left = windowWidth - menuWidth + 'px';
    }
    else {
      menu.style.left = clickCoordsX + 'px';
    }

    if ((windowHeight - clickCoordsY) < menuHeight) {
      menu.style.top = windowHeight - menuHeight + 'px';
    }
    else {
      menu.style.top = clickCoordsY + 'px';
    }
  }

  function menuItemListener( link ) {
    console.log(
      'Task ID - ' +
      taskItemInContext.getAttribute('data-id') +
      ', Task action - ' +
      link.getAttribute('data-action')
    );
    toggleMenuOff();
  }
  init();
})();
