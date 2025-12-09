extends Control

@onready var showhint52 = $showhint52
@onready var hint52 = $hint52

var codes := ["0312"]

func _ready():
	
	TimeTracker.start_scene("room52")

	
	var dialogue_label = $dialoguelabel52  # Let op: gebruik $ i.p.v. %

	var dialogue_res = preload("res://dialogue/dialogueroom52.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "startdialoguefivetwo")

	# Alles standaard verbergen
	$hint52.visible = false
	$hidehint52.visible = false

	$informatie52.visible = false
	$hideinformatie52.visible = false

	# LineEdit standaard zichtbaar
	$antwoord52.visible = true

	# Knoppen koppelen aan functies
	$showhint52.pressed.connect(_on_show_hint_52)
	$hidehint52.pressed.connect(_on_hide_hint_52)

	$showinformatie52.pressed.connect(_on_show_informatie_52)
	$hideinformatie52.pressed.connect(_on_hide_informatie_52)
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


# --- Hint 52 functionaliteit ---
func _on_show_hint_52():
	Events.use_hint("room52")
	$hint52.visible = true
	$hidehint52.visible = true

func _on_hide_hint_52():
	$hint52.visible = false
	$hidehint52.visible = false


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
