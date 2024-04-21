extends Node2D

############################
## DATA
############################
@export var arrow_speed: float = 1.5

@onready var arrow_line = $ArrowLine
@onready var arrow_pointer = $Marker2D/ArrowPointer
@onready var marker_2d = $Marker2D

var _stretching: bool = false
var _direction: Vector2 = Vector2.ZERO
var _active: bool = true
var _delayed_stretch: bool = false
############################
## INITIALIZATION
############################
func _ready():
	SignalAtlas.on_player_launched.connect(_on_player_launched)
	SignalAtlas.on_player_grounded.connect(_on_player_grounded)

############################
## PROCESS
############################
func _process(_delta):
	if _stretching and _direction:
		show()
		marker_2d.position += _direction * arrow_speed
		_clamp_marker_pos()
		_handle_arrow_graphics()

func _input(_event):
	if _stretching:
		_direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')

############################
## INTERFACE
############################
func start_stretching():
	if _active:
		_handle_arrow_graphics()
		_stretching = true
	else:
		_delayed_stretch = true

func stop_stretching():
	_stretching = false
	_reset_transformations()
	hide()

func is_stretching() -> bool:
	return _stretching

func current_marker_pos() -> Vector2:
	return marker_2d.global_position
############################
## INTERNAL UTILITIES
############################
func _handle_arrow_graphics():
	_rotate_line()
	_stretch_line()
	_rotate_pointer()
	pass

func _rotate_line():
	var rotation_angle = arrow_line.position.angle_to_point(marker_2d.position)
	arrow_line.rotation = rotation_angle

func _stretch_line():
	var distance = (arrow_line.position - marker_2d.position).length()
	var x_stretching = distance / (arrow_line.texture.get_width() + .6)
	arrow_line.scale.x = x_stretching

func _rotate_pointer():
	arrow_pointer.rotation = arrow_line.rotation

func _reset_transformations():
	arrow_line.rotate(0.0)
	arrow_line.scale.x = 1
	arrow_pointer.rotation_degrees = 0
	marker_2d.position = Vector2(17, 0)

func _clamp_marker_pos():
	var vp_size = get_viewport_rect().size
	var vp_corrected_size = vp_size / PI ## Pero POR QUÉ PASA ESTO XDIOS
	var clamp_x = Vector2(position.x - vp_corrected_size.x / 2, position.x + vp_corrected_size.x / 2)
	var clamp_y = Vector2(position.y - vp_corrected_size.y / 2, position.y + vp_corrected_size.y / 2)
	marker_2d.position.x = clampf(marker_2d.position.x, clamp_x.x, clamp_x.y)
	marker_2d.position.y = clampf(marker_2d.position.y, clamp_y.x, clamp_y.y)
############################
## SIGNAL HANDLING
############################
func _on_player_grounded():
	_active = true
	if _delayed_stretch:
		_delayed_stretch = false
		start_stretching()

func _on_player_launched(_pos):
	_active = false
