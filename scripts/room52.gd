extends Control

var codes := ["0312"]
var start_time = 0
@onready var instructions: Panel = $Instructions

func _ready():
	Events.current_room = 5
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND



	
func _process(_delta):
	Events.rooms["room5"]["time"] += (Time.get_ticks_msec() - start_time) / 1000.0





func _on_show_instuctions_pressed() -> void:
	instructions.visible = true


func _on_hide_instructions_pressed() -> void:
	instructions.visible = false
