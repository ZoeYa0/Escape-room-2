extends Control

@onready var showhint2 = $showhint2
@onready var hint2 = $hint2

# Nodes als variabelen voor makkelijk gebruik
var dialogue_label
var hint_sprite
var show_button
var hide_button
var start_time = 0
var dialogue_res = preload("res://dialogue/dialogueroom2.dialogue")

func _ready():
	Events.current_room = 2
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	
	#DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	
	
func _process(delta):
	Events.rooms["room2"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


# Antwoord invullen
var codes := ["92,86", "92.86", "92,86V", "92.86V", "92,86 V", "92.86 V", "92,86Volt", "92.86Volt", "92,86 Volt", "92.86 Volt", "92,86volt", "92.86volt", "92,86 volt", "92.86 volt"]

func _on_line_edit_text_submitted(password: String) -> void:
	if password not in codes:
		$antwoord2.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room3.tscn")
