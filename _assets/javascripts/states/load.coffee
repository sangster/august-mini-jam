window.loadState =
  preload: ->
    loadingLabel = game.add.text(game.width / 2, 400, 'loading...', {font: '50px Helvetica', fill: '#ffffff'})
    loadingLabel.anchor.setTo(0.5, 0.5)

    progressBar = game.add.sprite(game.width / 2, 300, 'progressBar')
    progressBar.anchor.setTo(0.5, 0.5)
    game.load.setPreloadSprite(progressBar)

  create: ->
    game.state.start('menu')
