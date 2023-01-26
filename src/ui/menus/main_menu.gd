extends CanvasLayer


"""
Set slide values to current volume values
"""
func _ready():
	$Options/VBoxContainer/master/MasterSlider.value = AudioServer.get_bus_volume_db(0)
	$Options/VBoxContainer/sound/SoundSlider.value = AudioServer.get_bus_volume_db(1)
	$Options/VBoxContainer/music/MusicSlider.value = AudioServer.get_bus_volume_db(2)
	if GameManager.menu_is_active: $Main.show()
	else: $Main.hide()



"""
Get keyboard inputs
"""
func _unhandled_input(event):
	if event is InputEventKey and GameManager.menu_is_active:
		if event.pressed:
			if event.scancode == KEY_ESCAPE or event.scancode == KEY_SPACE:
				if !GameManager.game_running:
					GameManager.game_running = true
					GameManager.menu_is_active = false
					MusicManager.fade_in()
					GameManager.start_new_game()
				else:
					if $Main.visible == true:
						GameManager.menu_is_active = false
						$Main.hide()
						$Options.hide()
						$Help.hide()
					else:
						GameManager.menu_is_active = true
						$Main.show()
			
			if event.scancode == KEY_O: $Options.show()
			if event.scancode == KEY_F1: $Help.show()
			if event.scancode == KEY_Q: GameManager.quit_game()



"""
Container in menu used as buttons
"""
func _on_start_gui_input(event):
	if event is InputEventMouseButton:
		if !GameManager.game_running:
			GameManager.game_running = true
			MusicManager.fade_in()
			GameManager.menu_is_active = false
			GameManager.start_new_game()
		else: 
			$Main.hide()
			$Options.hide()
			$Help.hide()
			GameManager.menu_is_active = false



"""
Buttons to show sub menus / quit
"""
func _on_options_gui_input(event):
	if event is InputEventMouseButton: $Options.show()

func _on_help_gui_input(event):
	if event is InputEventMouseButton: $Help.show()

func _on_quit_gui_input(event):
	if event is InputEventMouseButton:
		GameManager.quit_game()



"""
Buttons to hide sub menus
"""
func _on_OptionsButton_pressed():
	$Options.hide()

func _on_HelpButton_pressed():
	$Help.hide()



"""
Controls to change config
"""
func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)

func _on_FullscreenCheckBtn_toggled(_button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen

