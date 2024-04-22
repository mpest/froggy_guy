extends Control
############################
## DATA
############################
@onready var panel_2 = $GameOver/Panel2
@onready var animation_player = $AnimationPlayer
@onready var next_button = $GameOver/Panel/MC/VB/HB/NextButton
@onready var effects_player = $EffectsPlayer

############################
## INITIALIZATION
############################

############################
## PROCESS
############################

############################
## INTERFACE
############################

############################
## INTERNAL UTILITIES
############################

############################
## SIGNAL HANDLING
############################
func _on_replay_button_button_up():
	Director.load_level(Director.get_loaded_level_num())

func _on_main_menu_button_button_up():
	Director.load_main_menu()

func _on_exit_button_button_up():
	get_tree().quit()

func _on_next_button_button_up():
	if Director.get_loaded_level_num() + 1 <= Director.get_loaded_levels_count():
		Director.load_level(Director.get_loaded_level_num() + 1)
	else:
		animation_player.play('show')

func _on_next_button_visibility_changed():
	next_button.grab_focus()

func _on_visibility_changed():
	if visible:
		SoundManager.play_sound(effects_player, SoundManager.CHEER)
