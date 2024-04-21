class_name Platform extends Area2D
############################
## DATA
############################
var _stepped_on: bool = false

############################
## INITIALIZATION
############################

############################
## PROCESS
############################

############################
## INTERFACE
############################
func is_player_stepped_on() -> bool:
	return _stepped_on

############################
## INTERNAL UTILITIES
############################

############################
## SIGNAL HANDLING
############################
func _on_body_entered(_body):
	_stepped_on = true

func _on_body_exited(_body):
	_stepped_on = false
