window.menuState =
  create: ->
    console.log("menu::create")

    game.add.image(0,0,'bg')

    nameLabel = game.add.text(game.width / 2, 100, 'Super Drunk Falling Man', {font: '60px Helvetica', fill: '#ffffff'})
    nameLabel.anchor.setTo(0.5, 0.5)

    scoreLabel = game.add.text(game.width / 2, game.height / 2, "score: #{game.global.score}", {font: '30px Helvetica', fill: '#ffffff'})
    scoreLabel.anchor.setTo(0.5, 0.5)

    startLabel = game.add.text(game.width / 2, game.height - 100, "press the UP key to start", {font: '30px Helvetica', fill: '#ffffff'})
    startLabel.anchor.setTo(0.5, 0.5)

    upKey = game.input.keyboard.addKey(Phaser.Keyboard.UP)
    upKey.onDown.add(this.start, this)

  start: ->
    console.log("menu::start")
    game.state.start('play')
