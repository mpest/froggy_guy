extends TextureButton
############################
## DATA
############################
@export var text_shown: String = "lel"

@onready var audio_player = $AudioPlayer
@onready var label = $Label

############################
## INITIALIZATION
############################
func _ready():
	label.text = text_shown

############################
## PROCESS
############################

############################
## INTERFACE
############################

############################
## INTERNAL UTILITIES
############################
func _play_button_down():
	audio_player.play()

############################
## SIGNAL HANDLING
############################
func _on_button_down():
	_play_button_down()

func _on_button_up():
	_play_button_down()
