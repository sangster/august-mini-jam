window.playState =
  create: ->
    game.add.image(0,0,'bg')
    @direction = 1

    game.global.score = 0

    game.stage.backgroundColor = '#3498db'

    @cursor = game.input.keyboard.createCursorKeys()

    @player = game.add.sprite(game.width/2, 100, 'player')
    @player.anchor.setTo(0.5, 0.5)
    game.physics.arcade.enable(@player)
    @player.body.gravity.y = 500
    @player.animations.add('left', [1, 2], 8, true)
    @player.animations.add('right', [3, 4], 8, true)

    @floaters = game.add.group()
    @floaters.enableBody = true
    @floaters.createMultiple(10, 'line')
    @floaters.setAll('body.immovable', true)
    @floaters.setAll('checkWorldBounds', true)
    @floaters.setAll('outOfBoundsKill', true)
    game.time.events.loop(3000, @addFloater, @)

    @dirTimer = game.time.create(false)
    @dirTimer.duration = 1000
    @dirTimer.onComplete.add(@changeDir, @)

    game.input.keyboard.onDownCallback = (e) =>
      if e.keyCode == Phaser.Keyboard.UP
        @dirTimer.start()
    game.input.keyboard.onUpCallback = (e) =>
      if e.keyCode == Phaser.Keyboard.UP
        @dirTimer.destroy()

    @createWorld()
    @addFloater(game.width / 2)


  update: ->
    game.physics.arcade.collide(@player, @walls)
    game.physics.arcade.collide(@player, @floaters)
    game.physics.arcade.overlap(@player, @portal, @moveToTop, null, @)
    game.physics.arcade.overlap(@player, @top, @playerDie, null, @)

    @movePlayer()
    @playerDie() unless @player.inWorld


  movePlayer: ->

    if @cursor.up.isDown
      if @direction
        @player.body.velocity.x = -200
        @player.animations.play('left')
      else
        @player.body.velocity.x = 200
        @player.animations.play('right')
    else
      @player.body.velocity.x = 0
      @player.animations.stop()
      @player.animations.frame = 0


  moveToTop: ->
    console.log("play::moveToTop")
    @player.y = 0


  createWorld: ->
    @walls = game.add.group()
    @walls.enableBody = true

    # invisible walls
    left = game.add.sprite(1, 0, null, 0, @walls)
    left.height = game.height
    left.width = 0

    right = game.add.sprite(game.width - 1, 0, null, 0, @walls)
    right.height = game.height
    right.width = 0

    # Portal
    @portal = game.add.sprite(0, game.height - 1, null, 0)
    @portal.height = 1
    @portal.width = game.width
    game.physics.arcade.enable(@portal)

    # Top Trap
    @top = game.add.sprite(0, 0, 'top', 0)
    @top.height = @top.height / 2
    @top.width = game.width
    game.physics.arcade.enable(@portal)

    @walls.setAll('body.immovable', true)


  addFloater: (loc) ->
    console.log('play::addFloater')
    float = @floaters.getFirstDead()
    unless float
      console.log('play::noFloatersLeft')
      return

    unless loc
      locations = [
        0,
        game.width / 0.5,
        game.width / 2,
        game.width / 4,
        game.width,
      ]
      loc = game.rnd.pick(locations)

    float.anchor.setTo(0.5, 0)
    float.reset(loc, game.height)
    float.outOfBoundsKill = true

    game.physics.arcade.moveToXY(float, float.x, -10000)

  playerDie: ->
    game.state.start('menu')

  changeDir: ->
    console.log('MOOO')
