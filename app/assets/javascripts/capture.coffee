window.Capture ?= {}

class Capture.app
  'use strict'

  constructor: ->
    @video = document.getElementById 'video'
    @play  = document.getElementById 'play'
    @stop  = document.getElementById 'stop'

  launchCapture: ->
    navigator.getUserMedia = @assignBrowser()

    @play.addEventListener 'click', =>
      navigator.getUserMedia @mediaConstraints(), @mediaStream(), @mediaError()

    @stop.addEventListener 'click', =>
      @video.pause()
      @video.stream.stop()

  assignBrowser: ->
    navigator.getUserMedia       ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia    ||
    navigator.msGetUserMedia

  mediaConstraints: -> { video: true, audio: true }

  mediaStream: ->
    (stream) ->
      @video.stream = stream
      @video.src    = window.URL.createObjectURL @video.stream
      @video.play()

  mediaError: ->
    (e) -> console.error 'media error', e

cam = new Capture.app
cam.launchCapture()
