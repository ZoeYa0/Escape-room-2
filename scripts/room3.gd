extends Control


var codes := ["70"]  # juiste antwoorden als strings
var start_time = 0

func _ready():
	Events.current_room = 3
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


	var dialogue_res = preload("res://dialogue/dialogueroom3.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")

	
func _process(delta):
	Events.rooms["room3"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


### --- q10 functies ---
func _on_showq10_pressed():
	$hideq10.visible = true
	$q10.visible = true

func _on_hideq10_pressed():
	$hideq10.visible = false
	$q10.visible = false


### --- antwoordinvullen functie ---
func _on_showantwoordinvullen_pressed():
	$antwoordinvullen.visible = true
	$antwoordinvullen.grab_focus()  # automatisch cursor erin zetten


func _on_antwoordinvullen_text_submitted(new_text: String) -> void:
	var antwoord = new_text.strip_edges()  # verwijder spaties voor/achter

	if antwoord not in codes:
		$antwoordinvullen.clear()  # leegmaken bij fout antwoord
	else:
		get_tree().change_scene_to_file("res://scenes/room4.tscn")
