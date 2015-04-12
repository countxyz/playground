Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w(
  main.js
  imageEditor/imageEditorHelper.js
  imageEditor/imageEditor.js
  contextMenu/contextMenuHelper.js
  contextMenu/contextMenu.js
)
