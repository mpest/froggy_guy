extends CharacterBody2D
############################
## DATA
############################
@export var jump_speed: float = 500.0
@onready var camera_2d = $Camera2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var arrow = $Arrow

const VIBRATING_SHADER = preload("res://assets/shaders/vibrating.gdshader")

var _jumping: bool = false
var _played_once: bool = false
############################
## INITIALIZATION
############################
const VIBRATING = preload("res://assets/shaders/vibrating.gdshader")
############################
## PROCESS
############################
func _input(event):
	if event.is_action_pressed('button_a') and arrow.is_stretching():
		animated_sprite_2d.play('jump')
		_launch(arrow.current_marker_pos())
		arrow.stop_stretching()
		_played_once = false

	var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	if direction:
		_play_once()
		arrow.start_stretching()

func _physics_process(_delta):
	if _jumping:
		move_and_slide()

############################
## INTERFACE
############################
func stop_jump():
	animated_sprite_2d.play('idle')
	_jumping = false
	velocity = Vector2.ZERO

func fall():
	animated_sprite_2d.play('idle')
	pass

############################
## INTERNAL UTILITIES
############################
func _launch(target_pos: Vector2):
	_jumping = true
	## Calculate the direction for the velocity
	var vel = (target_pos - global_position).normalized()
	velocity = jump_speed * vel
	material.shader = null
	SignalAtlas.on_player_launched.emit(target_pos)

func _play_once():
	if not _played_once:
		animated_sprite_2d.play('charge_jump')
		material.shader = VIBRATING_SHADER
		material.set_shader_parameter('amplitude', 0.002)
		material.set_shader_parameter('frequency', 90)
		_played_once = true
############################
## SIGNAL HANDLING
############################
