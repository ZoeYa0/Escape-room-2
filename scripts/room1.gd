extends Node2D

@onready var show_hint: Button = $ShowHint
@onready var show_opdracht: Button = $ShowOpdracht
@onready var hint: Node2D = $Hint
@onready var opdracht: Panel = $Opdracht
@onready var inner_box: Panel = $Opdracht/InnerBox
@onready var label: Label = $Opdracht/InnerBox/Label
@onready var title: Label = $Opdracht/InnerBox/Title
@onready var line_edit: LineEdit = $Opdracht/InnerBox/LineEdit
@onready var antwoord: Label = $Opdracht/InnerBox/Antwoord
@onready var hide_opdracht: Button = $Opdracht/HideOpdracht
@onready var _1_table: Sprite2D = $"Opdracht/1Table"




var start_time = 0
var dialogue_res = preload("res://dialogue/dialogueroom1.dialogue")
@export var ending: DialogueResource

func _ready():
	TranslationServer.set_locale("nl")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	Events.current_room = 1
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


	#DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	hint.visible = false
	
	
func _process(_delta):
	Events.rooms["room1"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0

func _on_show_opdracht_pressed() -> void:
	opdracht.visible = true

var codes := ["2.83", "2,83", "2.83 mg/m^3", "2,83 mg/m^3"]
func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text not in codes:
		line_edit.clear()
		Events.rooms["room1"]["wrong"] +=1
		return
	else:
		DialogueManager.show_dialogue_balloon(ending, "start")
		


func _on_hide_opdracht_pressed() -> void:
	opdracht.visible = false

func _on_dialogue_ended(dialogue):
	if dialogue == ending:
		get_tree().change_scene_to_file("res://scenes/room2.tscn")
	
