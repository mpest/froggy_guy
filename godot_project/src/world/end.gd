class_name EndPlatform extends Platform
############################
## DATA
############################

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
func _on_body_entered(_body):
	_stepped_on = true

func _on_body_exited(_body):
	_stepped_on = false
