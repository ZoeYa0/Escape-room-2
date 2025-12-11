extends Control

@onready var achtergrond_2: Sprite2D = $achtergrond2
@onready var _2_dead: Sprite2D = $"2Dead"
@onready var _2_alive: Sprite2D = $"2Alive"
@onready var show_hint: Button = $ShowHint
@onready var show_opdracht: Button = $ShowOpdracht
@onready var hint: Node2D = $Hint
@onready var opdracht_2: Panel = $Opdracht2
@onready var inner_box: Panel = $Opdracht2/InnerBox
@onready var description: Label = $Opdracht2/InnerBox/Description
@onready var title: Label = $Opdracht2/InnerBox/Title
@onready var antwoord: Label = $Opdracht2/InnerBox/Antwoord
@onready var hide_opdracht: Button = $Opdracht2/HideOpdracht
@onready var answer_field: LineEdit = $AnswerField
@onready var alarm: Button = $Alarm
@onready var system: Panel = $System
@onready var hide_system: Button = $System/HideSystem
@onready var puzzle_controller: Node2D = $System/PuzzleController
@onready var show_alarm: Button = $ShowAlarm
@onready var instruction_alarm: Panel = $InstructionAlarm
@onready var arrow: Button = $Arrow
@onready var security_alarm: AudioStreamPlayer = $SecurityAlarm

var start_time = 0
var power_on = false
var dialogue_res = preload("res://dialogue/dialogueroom2.dialogue")
@export var ending: DialogueResource
@export var no_power: DialogueResource

func _ready():
	arrow.visible = false
	show_alarm.visible = false
	instruction_alarm.visible = false
	system.visible = false
	Events.current_room = 2
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	puzzle_controller.puzzle_solved.connect(on_puzzle_solved)
	
func _process(_delta):
	Events.rooms["room2"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


var codes := ["2.4", "2,4"]


func _on_show_opdracht_pressed() -> void:
	opdracht_2.visible = true


func _on_answer_field_text_submitted(new_text: String) -> void:
	if new_text not in codes:
		answer_field.clear()
		Events.rooms["room2"]["wrong"] += 1
		return
	else:
		power_on = true
		show_alarm.visible = true
		answer_field.add_theme_color_override("font_color", Color.GREEN)#no bg color on textedit
		answer_field.editable = false
		security_alarm.play(11.15)

func _on_hide_opdracht_pressed() -> void:
	opdracht_2.visible = false


func _on_alarm_pressed() -> void:
	if power_on:
		system.visible = true
	else:
		DialogueManager.show_dialogue_balloon(no_power,'start')


func _on_hide_system_pressed() -> void:
	system.visible = false
	
func on_puzzle_solved():
	system.visible = false
	DialogueManager.show_dialogue_balloon(ending,'start')
	alarm.modulate = Color.RED
	show_alarm.visible = false
	arrow.visible = true


func _on_hide_alarm_pressed() -> void:
	instruction_alarm.visible = false


func _on_show_alarm_pressed() -> void:
	instruction_alarm.visible = true


func _on_arrow_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/room3.tscn")
