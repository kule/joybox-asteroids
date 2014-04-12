class GameLayer < Joybox::Core::Layer
  def on_enter
    SpriteFrameCache.frames.add file_name: 'sprite_sheets/game_sprite_sheet.plist'
    
    @sprite_batch = SpriteBatch.new file_name: 'sprite_sheets/game_sprite_sheet.png'
    self << @sprite_batch

    @spaceship = Sprite.new frame_name: 'spaceship.png', position: Screen.center
    @sprite_batch << @spaceship

    @spaceship[:alive] = true

    on_touches_began do |touches, event|
      touch = touches.any_object
      @spaceship.run_action Move.to(position: touch.location) if @spaceship[:alive]
    end

    schedule_update do |dt|
      launch_asteroids
      check_for_collisions if @spaceship[:alive]
    end
  end

  MaximumAsteroids = 10

  def launch_asteroids
    @asteroids ||= Array.new

    if @asteroids.size <= MaximumAsteroids
      missing_asteroids = MaximumAsteroids - @asteroids.size

      missing_asteroids.times do
        asteroid = AsteroidSprite.new
        move_action = Move.to(position: asteroid.end_position, duration: 4.0)

        callback_action = Callback.with { |asteroid| @asteroids.delete(asteroid) }

        asteroid.run_action Sequence.with actions: [move_action, callback_action]

        @sprite_batch << asteroid
        @asteroids << asteroid
      end
    end
  end

  def check_for_collisions
    @asteroids.each do |asteroid|
      if CGRectIntersectsRect(asteroid.bounding_box, @spaceship.bounding_box)
        @asteroids.each(&:stop_all_actions)
        @spaceship[:alive] = false
        @spaceship.run_action Blink.with(times: 10, duration: 1.0)
        break
      end
    end
  end
end
