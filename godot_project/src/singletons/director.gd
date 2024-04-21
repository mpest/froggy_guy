extends Node
############################
## DATA
############################
const TAG_LEVEL_DICT: Dictionary = {
	1 : preload("res://src/levels/level_1.tscn"),
	2 : preload("res://src/levels/level_2.tscn"),
	3 : preload("res://src/levels/level_3.tscn"),
}
const MAIN_MENU = preload("res://src/ui/main_menu.tscn")

var _selected_level: int = 0
############################
## INITIALIZATION
############################

############################
## PROCESS
############################

############################
## INTERFACE
############################
func load_main_menu():
	get_tree().change_scene_to_packed(MAIN_MENU)

func load_level(level_num: int):
	_selected_level = level_num
	var scene = TAG_LEVEL_DICT[level_num]
	get_tree().change_scene_to_packed(scene)

func get_loaded_levels_count():
	return TAG_LEVEL_DICT.size()

func get_loaded_level_num():
	return _selected_level
############################
## INTERNAL UTILITIES
############################

############################
## SIGNAL HANDLING
############################
