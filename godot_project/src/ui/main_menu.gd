extends Control
############################
## DATA
############################
@onready var effects_player = $EffectsPlayer
@onready var level_label = $MC/VB/HB/LevelTexture/Label
@onready var tutorial_panel = $MC/TutorialPanel
@onready var play_button = $MC/VB/PlayButton

############################
## INITIALIZATION
############################
func _ready():
	play_button.grab_focus()

############################
## PROCESS
############################

############################
## INTERFACE
############################

############################
## INTERNAL UTILITIES
############################
func _update_level_label(with: String):
	level_label.text = with

############################
## SIGNAL HANDLING
############################
func _on_left_button_button_down():
	effects_player.stream = SoundManager.BUTTON_PRESSED_SOUND
	effects_player.play()
func _on_right_button_button_down():
	effects_player.stream = SoundManager.BUTTON_PRESSED_SOUND
	effects_player.play()

func _on_left_button_button_up():
	effects_player.stream = SoundManager.BUTTON_PRESSED_SOUND
	effects_player.play()
	var level_num = int(level_label.text)
	var new_level_num
	if level_num == 1:
		new_level_num = Director.get_loaded_levels_count()
	else:
		new_level_num = level_num - 1
	_update_level_label(str(new_level_num))

func _on_right_button_button_up():
	effects_player.stream = SoundManager.BUTTON_PRESSED_SOUND
	effects_player.play()
	var level_num = int(level_label.text)
	var new_level_num
	if level_num == Director.get_loaded_levels_count():
		new_level_num = 1
	else:
		new_level_num = level_num + 1
	_update_level_label(str(new_level_num))


func _on_exit_button_button_up():
	get_tree().quit(0)

func _on_play_button_button_up():
	Director.load_level(int(level_label.text))

func _on_quit_button_button_up():
	tutorial_panel.hide()

func _on_tutorial_button_button_up():
	tutorial_panel.show()
