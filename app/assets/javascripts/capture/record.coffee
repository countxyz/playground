window.Record ?= {}

class Record.app
  'use strict'

  recordCapture: ->
    document.querySelector('#start-recording').onclick = =>
      @disabled = true
      navigator.getUserMedia @mediaConstraints(), onMediaSuccess, onMediaError

    document.querySelector('#stop-recording').onclick = ->
      @disabled = true
      multiStreamRecorder.stop()
      multiStreamRecorder.stream.stop() if multiStreamRecorder.stream

    multiStreamRecorder = undefined
    audioVideoBlobs     = {}
    recordingInterval   = 0

    onMediaSuccess = (stream) ->
      video = document.createElement('video')
      video = mergeProps(video,
        controls: true
        src: URL.createObjectURL(stream))
      video.addEventListener 'loadedmetadata', (->

        appendLink = (blob) ->
          a           = document.createElement('a')
          a.target    = '_blank'
          a.innerHTML = 'Open Recorded ' +
          (if blob.type == 'audio/ogg' then 'Audio' else 'Video') + ' No. ' +
          index++ + ' (Size: ' + bytesToSize(blob.size) + ') Time Length: ' +
          getTimeLength(timeInterval)
          a.href = URL.createObjectURL blob
          container.appendChild a
          container.appendChild document.createElement 'hr'

        multiStreamRecorder        = new MultiStreamRecorder stream
        multiStreamRecorder.canvas = { width: video.width, height: video.height }
        multiStreamRecorder.video  = video

        multiStreamRecorder.ondataavailable = (blobs) ->
          appendLink blobs.audio
          appendLink blobs.video

        timeInterval = document.querySelector('#time-interval').value

        if timeInterval
          timeInterval = parseInt timeInterval
        else
          timeInterval = 5 * 1000

        multiStreamRecorder.start timeInterval
        document.querySelector('#stop-recording').disabled = false
      ), false
      video.play()
      container.appendChild video
      container.appendChild document.createElement 'hr'

    container = document.getElementById('container')
    index     = 1

    onMediaError = (e) -> console.error 'media error', e

    bytesToSize = (bytes) ->
      k = 1000
      sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB' ]

      return '0 Bytes' if bytes == 0
      i = parseInt(Math.floor(Math.log(bytes) / Math.log(k)), 10)
      (bytes / k ** i).toPrecision(3) + ' ' + sizes[i]

    getTimeLength = (milliseconds) ->
      data = new Date milliseconds
      data.getUTCHours()   + ' hours, '      +
      data.getUTCMinutes() + ' minutes and ' +
      data.getUTCSeconds() + ' second(s)'

    window.onbeforeunload = ->
      document.querySelector('#start-recording').disabled = false

  mediaConstraints: ->
    audio: true
    video: mandatory:
      maxWidth: 1280
      maxHeight: 720

cam = new Record.app
cam.recordCapture()
