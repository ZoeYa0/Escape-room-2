extends Control
@onready var bg: Sprite2D = $bg
@onready var bg_2: Sprite2D = $bg2
@onready var hint_51: Sprite2D = $hint51
@onready var show_hint: Button = $ShowHint
@onready var showinformatie_51: Button = $showinformatie51
@onready var antwoord_51: LineEdit = $antwoord51
@onready var timer_label: Label = $TimerLabel
@onready var hint: Node2D = $Hint
@onready var instructions: Panel = $Instructions
@onready var informatie_51: Sprite2D = $Instructions/informatie51
@onready var informatie_52: Sprite2D = $Instructions/informatie52
@onready var hide_instructions: Button = $Instructions/HideInstructions
@onready var lasers: AudioStreamPlayer = $Lasers
@onready var antwoord_52: LineEdit = $antwoord52



var start_time = 0
func _ready():
	bg.visible = true
	bg_2.visible = false
	antwoord_51.visible = true
	antwoord_52.visible = false
	Events.current_room = 5
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	var dialogue_res = preload("res://dialogue/dialogueroom51.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")

	instructions.visible = false
	
func _process(delta):
	Events.rooms["room5"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


# --- Codecontrole ---
var code_1 := ["377459"]
var code_2 := ["0312"]

func _on_antwoord_51_text_submitted(password: String) -> void:
	if password not in code_1:
		$antwoord51.clear()
		return
	else:
		lasers.play(2.3)
		Events.room5_part2 = true
		bg_2.visible = true
		antwoord_51.visible = false
		antwoord_52.visible = true
		var dialogue_res = preload("res://dialogue/dialogueroom52.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_res, "start")
		
func _on_antwoord_52_text_submitted(password: String) -> void:
	if password not in code_2:
		$antwoord52.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room6.tscn")

func _on_showinformatie_51_pressed() -> void:
	instructions.visible = true


func _on_hide_instructions_pressed() -> void:
	instructions.visible = false
