extends Control

@onready var instructions: Node2D = $Instructions
@onready var rightanswer_952192: AudioStreamPlayer = $Audio/Rightanswer952192
@onready var wronganswer_37702: AudioStreamPlayer = $Audio/Wronganswer37702

var codes := ["70"]  # juiste antwoorden als strings
var start_time = 0

func _ready():
	Events.current_room = 3
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


	var dialogue_res = preload("res://dialogue/3_start.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")

	
func _process(_delta):
	Events.rooms["room3"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


func _on_antwoordinvullen_text_submitted(new_text: String) -> void:
	var antwoord = new_text.strip_edges()  # verwijder spaties voor/achter

	if antwoord not in codes:
		$antwoordinvullen.clear()
		wronganswer_37702.play()
		Events.rooms["room3"]["wrong"] += 1
	else:
		rightanswer_952192.play()
		get_tree().change_scene_to_file("res://scenes/room4.tscn")


func _on_q_10_pressed() -> void:
	instructions.visible = true
	$Instructions/Label.text = tr("INSTRUCTION_3.0")


func _on_hideq_10_pressed() -> void:
	instructions.visible = false
	
