Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w(
  main.js
  imageEditor.js
  contextMenu.js
  capture.js
)
