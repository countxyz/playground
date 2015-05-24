class Annotator.app
  'use strict'

  helper = Annotator.helper

  constructor: ->
    @video = document.getElementById 'video'

  launchAnnotator: ->
    navigator.getUserMedia = helper.assignBrowser()

    document.getElementById('play').addEventListener 'click', =>
      navigator.getUserMedia @mediaConstraints(), @mediaStream(), @mediaError()

    document.getElementById('stop').addEventListener 'click', =>
      @video.pause()

  mediaConstraints: -> { video: true, audio: true }

  mediaStream: ->
    (stream) ->
      @video.src = window.URL.createObjectURL stream
      @video.play()

  mediaError: ->
    (e) -> console.error 'media error', e

cam = new Annotator.app
cam.launchAnnotator()
