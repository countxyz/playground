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
      @video.stream.stop()

  mediaConstraints: -> { video: true, audio: true }

  mediaStream: ->
    (stream) ->
      @video.stream = stream
      @video.src = window.URL.createObjectURL @video.stream
      @video.play()

  mediaError: ->
    (e) -> console.error 'media error', e

cam = new Annotator.app
cam.launchAnnotator()
