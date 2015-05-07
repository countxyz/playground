'use strict'

$ ->
  do ->
    dlgtrigger = document.querySelector('[data-dialog]')
    somedialog = document.getElementById(dlgtrigger.getAttribute('data-dialog'))
    dlg = new DialogFx(somedialog)
    dlgtrigger.addEventListener 'click', dlg.toggle.bind(dlg)
