extends Control


var start_time = 0
func _ready():
	Events.current_room = 5
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	var dialogue_res = preload("res://dialogue/dialogueroom51.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")

	$informatie51.visible = false
	$hideinformatie51.visible = false
	
func _process(delta):
	Events.rooms["room5"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0



# --- Informatie 51 ---
func _on_show_informatie_51():
	$informatie51.visible = true
	$hideinformatie51.visible = true

	# LineEdit moet verdwijnen
	$antwoord51.visible = false


func _on_hide_informatie_51():
	$informatie51.visible = false
	$hideinformatie51.visible = false

	# LineEdit komt terug
	$antwoord51.visible = true



# --- Codecontrole ---
var codes := ["377459"]

func _on_antwoord_51_text_submitted(password: String) -> void:
	if password not in codes:
		$antwoord51.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room52.tscn")
