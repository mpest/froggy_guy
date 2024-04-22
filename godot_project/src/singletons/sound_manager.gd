extends Node
############################
## DATA
############################
const BUTTON_PRESSED_SOUND = preload("res://assets/audio/kick_wood.ogg")
const SPLASH_SOUND = preload("res://assets/audio/splash.ogg")
const SPLASH = preload("res://assets/sfx/22_Water_02.wav")
const LANDING2 = preload("res://assets/sfx/45_Landing_01.wav")
const LANDING = preload("res://assets/sfx/03_Claw_03.wav")
const CHEER = preload("res://assets/sfx/051_use_item_01.wav")
############################
## INITIALIZATION
############################

############################
## PROCESS
############################

############################
## INTERFACE
############################
func play_sound(stream_player: AudioStreamPlayer2D, sound): # Based on the consts contained in this very class
	stream_player.stream = sound
	stream_player.play()

############################
## INTERNAL UTILITIES
############################

############################
## SIGNAL HANDLING
############################
