'use strict'

window.Annotator ?= {}

Annotator.helper = {
  assignBrowser: ->
    navigator.getUserMedia       ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia    ||
    navigator.msGetUserMedia
}
