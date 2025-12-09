extends Control

var codes := ["0312"]
var start_time = 0

func _ready():
	Events.current_room = 5
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


	var dialogue_res = preload("res://dialogue/dialogueroom52.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")


	$informatie52.visible = false
	$hideinformatie52.visible = false

	# LineEdit standaard zichtbaar
	$antwoord52.visible = true

	$showinformatie52.pressed.connect(_on_show_informatie_52)
	$hideinformatie52.pressed.connect(_on_hide_informatie_52)
	
func _process(_delta):
	Events.rooms["room5"]["time"] += (Time.get_ticks_msec() - start_time) / 1000.0



# --- Informatie 52 functionaliteit ---
func _on_show_informatie_52():
	$informatie52.visible = true
	$hideinformatie52.visible = true
	$antwoord52.visible = false  # LineEdit verdwijnt


func _on_hide_informatie_52():
	$informatie52.visible = false
	$hideinformatie52.visible = false
	$antwoord52.visible = true  # LineEdit verschijnt weer


# --- LineEdit submit functionaliteit ---
func _on_antwoord_52_text_submitted(password: String) -> void:
	if password not in codes:
		$antwoord52.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room6.tscn")
