class MenuLayer < Joybox::Core::Layer
  def on_enter
    background_sprite = Sprite.new  file_name: 'sprites/menu/background.png',
                                    position: Screen.center
    self << background_sprite

    start_button = MenuImage.new image_file_name: 'sprites/menu/start.png',
      selected_image_file_name: 'sprites/menu/start.png',
      disabled_image_file_name: 'sprites/menu/start.png' do |menu_item|
        
      Joybox.director << GameScene.new
    end

    menu = Menu.new position: [Screen.half_width, 100.0], items: [start_button]

    self << menu
  end
end