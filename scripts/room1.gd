extends Node2D

@onready var achtergrond_1: Sprite2D = $achtergrond1
@onready var show_hint: Button = $ShowHint
@onready var antwoord: Button = $antwoord
@onready var show_opdracht: Button = $ShowOpdracht
@onready var hint: Node2D = $Hint
@onready var answer: Node2D = $Answer
@onready var line_edit: LineEdit = $Answer/LineEdit
@onready var label: Label = $Answer/Label
@onready var opdracht: Panel = $Opdracht


var start_time = 0
var dialogue_res = preload("res://dialogue/dialogueroom1.dialogue")

func _ready():
	TranslationServer.set_locale("nl")
	Events.current_room = 1
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


	#DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	hint.visible = false
	
	
func _process(_delta):
	Events.rooms["room1"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0

# --- OPDRACHT1 BUTTONS ---
func _on_show_opdracht_pressed() -> void:
	opdracht.visible = true

var codes := ["2.83", "2,83", "2.83 mg/m^3", "2,83 mg/m^3"]

func _on_answer_text_submitted(new_text: String) -> void:
	if new_text not in codes:
		line_edit.clear()
		return
	else:
		get_tree().change_scene_to_file("res://scenes/room2.tscn")
		Events.rooms["room1"]["wrong"] +=1

#func _on_antwoord_pressed() -> void:
	#var answer = line_edit.text.strip_edges()
	#if answer.to_lower() not in codes: 
		#label.clear()
		#return	
	#else:
		#Events.rooms["room1"]["wrong"] +=1
		#get_tree().change_scene_to_file("res://scenes/room2.tscn")


func _on_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.


func _on_hide_opdracht_pressed() -> void:
	opdracht.visible = false
