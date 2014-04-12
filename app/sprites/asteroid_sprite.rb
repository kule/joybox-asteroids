class AsteroidSprite < Joybox::Core::Sprite
  attr_reader :end_position

  def initialize
    @random = Random.new

    case @random.rand(1..4)
    when 1
      kind = 'large'
    when 2
      kind = 'medium'
    when 3
      kind = 'small'
    when 4
      kind = 'weird'
    end

    frame_name = "asteroid-#{kind}.png"
    screen_side = @random.rand(1..4)

    start_position = initial_position(screen_side)
    @end_position = final_position(screen_side)

    super frame_name: frame_name, position: start_position
  end

  # This is the maximum size of any of our asteroids, because their images are
  # rectangles only one value is needed.
  # We need this value to make sure that the asteroid will not appear on the edge
  # of the screen.
  MaximumSize = 96.0
  
  def initial_position(screen_side)
    case screen_side
    when 1
      # In case it spawns on the Left:
      # The X axis should be outside of the screen
      # The Y axis can be any point inside the height
      [-MaximumSize, @random.rand(1..Screen.height)]
    when 2
      # In case it spawns on the Top:
      # The X axis can be any point inside the width
      # The Y axis must be higher than the screen height
      [@random.rand(1..Screen.width), Screen.height + MaximumSize]
    when 3
      # In case it spawns on the Right:
      # The X axis must be greater than the entire screen width
      # The Y axis can by any value inside the total height
      [Screen.width + MaximumSize, @random.rand(1..Screen.height)]
    else
      # In case it spawns on the Bottom:
      # The X axis can be any value of the screen width
      # The Y axis should be lower than the total height
      [@random.rand(1..Screen.width), -MaximumSize]
    end
  end

  def final_position(screen_side)
    case screen_side
    when 1
      # In case it spawns on the Left:
      # The X axis must be bigger than the total width
      # The Y axis can be any point inside the height
      [Screen.width + MaximumSize, @random.rand(1..Screen.height)]
    when 2
      # In case it spawns on the Top:
      # The X axis can be any point inside the width
      # The Y axis must be lower than the initial screen height
      [@random.rand(1..Screen.width), -MaximumSize]
    when 3
      # In case it spawns on the Right:
      # The X axis must be lower than the start of the width
      # The Y axis can by any value inside the total height
      [-MaximumSize, @random.rand(1..Screen.height)]
    else
      # In case it spawns on the Bottom:
      # The X axis can be any value of the screen width
      # The Y axis should be higher than the total height
      [@random.rand(1..Screen.width), Screen.height + MaximumSize]
    end
  end
end