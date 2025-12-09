extends Control

@onready var showhint3 = $showhint3
@onready var hint3 = $hint3

var codes := ["70"]  # juiste antwoorden als strings

func _ready():
	
	TimeTracker.start_scene("room3")

	
	var dialogue_label = $dialoguelabel3
	var dialogue_res = preload("res://dialogue/dialogueroom3.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "startdialoguethree")

	# Verberg standaard de hide-knoppen en sprites
	$hideq10.visible = false
	$q10.visible = false

	$hidehint3.visible = false
	$hint3.visible = false

	# Verberg standaard antwoordinvullen
	$antwoordinvullen.visible = false

	# Connect knoppen q10
	$showq10.pressed.connect(_on_showq10_pressed)
	$hideq10.pressed.connect(_on_hideq10_pressed)

	# Connect knoppen hint3
	$showhint3.pressed.connect(_on_showhint3_pressed)
	$hidehint3.pressed.connect(_on_hidehint3_pressed)

	# Connect antwoordinvullen knop
	$showantwoordinvullen.pressed.connect(_on_showantwoordinvullen_pressed)

	# Connect LineEdit text_submitted signal
	$antwoordinvullen.text_submitted.connect(_on_antwoordinvullen_submitted)
	
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


### --- q10 functies ---
func _on_showq10_pressed():
	$hideq10.visible = true
	$q10.visible = true

func _on_hideq10_pressed():
	$hideq10.visible = false
	$q10.visible = false


### --- hint3 functies ---
func _on_showhint3_pressed():
	Events.use_hint("room3")
	$hidehint3.visible = true
	$hint3.visible = true

func _on_hidehint3_pressed():
	$hidehint3.visible = false
	$hint3.visible = false


### --- antwoordinvullen functie ---
func _on_showantwoordinvullen_pressed():
	$antwoordinvullen.visible = true
	$antwoordinvullen.grab_focus()  # automatisch cursor erin zetten

func _on_antwoordinvullen_submitted(password: String) -> void:
	var antwoord = password.strip_edges()  # verwijder spaties voor/achter

	if antwoord not in codes:
		$antwoordinvullen.clear()  # leegmaken bij fout antwoord
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room4.tscn")
