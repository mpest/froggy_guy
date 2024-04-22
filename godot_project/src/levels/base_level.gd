extends Node2D
############################
## DATA
############################
@onready var player = $Player
@onready var world = $world
@onready var ui = $CanvasLayer/UI
@onready var sound_tex_rect = $CanvasLayer/MC/SoundButton/MC/TextureRect
@onready var music_player = $MusicPlayer

const SOUND_OFF = preload("res://assets/ui/sound_off.png")
const SOUND_ON = preload("res://assets/ui/sound_on.png")
var _sound_on: bool = true

var _target_point: Vector2 = Vector2.ZERO
var _player_starting_pos: Vector2 = Vector2.ZERO
var _jumping = false
var _player_won = false
var _fallen = false
var _landed = true
############################
## INITIALIZATION
############################
func _ready():
	SignalAtlas.on_player_launched.connect(_on_player_launched)
	SignalAtlas.on_player_respawn.connect(_on_player_respawn)

############################
## PROCESS
############################
func _process(_delta):
	if _jumping:
		if _player_reached_destiny():
			if not _check_player_grounded():
				if not _fallen:
					_fall()
					_fallen = true
			elif _player_won:
				ui.show()
				player.set_process_input(false)
				player.set_physics_process(false)
			else:
				if not _landed:
					_landed = true
					player.land()
					SignalAtlas.on_player_grounded.emit()

############################
## INTERFACE
############################

############################
## INTERNAL UTILITIES
############################
func _player_reached_destiny():
	var trayectory = _target_point - _player_starting_pos
	var player_vec = player.global_position - _player_starting_pos
	if trayectory.length() > player_vec.length():
		return false
	else:
		return true

func _check_player_grounded():
	var output = false
	for child in world.get_children():
		if child.is_player_stepped_on():
			output = true
			if is_instance_of(child, EndPlatform):
				_player_won = true
	return output

func _fall():
	player.fall()

############################
## SIGNAL HANDLING
############################
func _on_player_launched(target_point):
	_player_starting_pos = player.global_position
	_target_point = target_point
	_landed = false
	_jumping = true

func _on_sound_button_button_up():
	if _sound_on:
		sound_tex_rect.texture = SOUND_OFF
		_sound_on = false
		music_player.stop()
	else:
		sound_tex_rect.texture = SOUND_ON
		_sound_on = true
		music_player.play()

func _on_player_respawn():
	_fallen = false
	player.global_position = _player_starting_pos
	SignalAtlas.on_player_grounded.emit()
