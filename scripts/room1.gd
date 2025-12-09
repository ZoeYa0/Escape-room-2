extends Node2D

@onready var achtergrond_1: Sprite2D = $achtergrond1
@onready var showhint_1: Button = $showhint1
@onready var antwoord: Button = $antwoord
@onready var opdrachtknop: Sprite2D = $opdrachtknop
@onready var show_opdracht: Button = $ShowOpdracht
@onready var timer_label: Label = $TimerLabel
@onready var hint: Node2D = $Hint
@onready var hint_1: Sprite2D = $Hint/hint1
@onready var hidehint_1: Button = $Hint/hidehint1
@onready var opdracht: Node2D = $Opdracht
@onready var opdracht_1: Sprite2D = $Opdracht/opdracht1
@onready var hide_opdracht: Button = $Opdracht/HideOpdracht
@onready var answer: Node2D = $Answer
@onready var line_edit: LineEdit = $Answer/LineEdit
@onready var label: Label = $Answer/Label


func _ready():
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
	TimeTracker.start_scene("room1")

	
	@warning_ignore("unused_variable")
	var dialogue_res = preload("res://dialogue/dialogueroom1.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")

	# --- Startstatus ---
	hint.visible = false
	opdracht.visible = false
	answer.visible = false

	# --- Signals ---
	#show_button.pressed.connect(_on_showhint_1_pressed)
	#hide_button.pressed.connect(_on_hidehint_1_pressed)
	#antwoord_button.pressed.connect(_on_antwoord_pressed)
	#antwoordinvullen.text_submitted.connect(_on_antwoordinvullen_text_submitted)

	# ✔️ Nieuwe signals
	#show_opdracht1_button.pressed.connect(_on_show_opdracht1_pressed)
	#hide_opdracht1_button.pressed.connect(_on_hide_opdracht1_pressed)
	
	
func _process(_delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


# --- HINT BUTTONS ---
func _on_showhint_1_pressed() -> void:
	Events.rooms["room1"]["hints"] += 1
	

func _on_hidehint_1_pressed() -> void:
	hint.visible = false


# --- ANTWOORD BUTTON ---
func _on_antwoord_pressed() -> void:
	answer.visible = true


# --- OPDRACHT1 BUTTONS ---
func _on_show_opdracht_pressed() -> void:
	opdracht.visible = true

func _on_hide_opdracht_pressed() -> void:
	opdracht.visible = false



# --- INVOER CONTROLEREN ---
var codes := ["2.83", "2,83", "2.83 mg/m^3", "2,83 mg/m^3"]


func _on_answer_text_submitted(new_text: String) -> void:
	if new_text not in codes:
		label.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room2.tscn")
