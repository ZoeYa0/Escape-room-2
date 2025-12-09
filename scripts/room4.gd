extends Control

@onready var showhint4 = $showhint4
@onready var hint4 = $hint4

var clicked_numbers := []        # Lijst met aangeklikte nummers
var total_numbers := 12          # Totaal aantal getalknoppen
var next_scene_path := "res://scenes/room5.tscn"

func _ready():
	
	TimeTracker.start_scene("room41")

	
	var dialogue_label = $dialoguelabel4
	var dialogue_res = preload("res://dialogue/dialogueroom4.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "startdialoguefour")

	# Verbind vraag-knoppen
	$showvraag4.pressed.connect(_on_showvraag4_pressed)
	$hidevraag4.pressed.connect(_on_hidevraag4_pressed)

	# Verbind hint-knoppen
	$showhint4.pressed.connect(_on_showhint4_pressed)
	$hidehint4.pressed.connect(_on_hidehint4_pressed)

	# Verbind getalknoppen (getal1 t/m getal12)
	for i in range(1, total_numbers + 1):
		var btn_name := "getal%d" % i
		if has_node(btn_name):
			var button = get_node(btn_name)
			# Geef zowel het nummer als de button zelf mee
			button.pressed.connect(_on_getal_pressed.bind(i, button))
		else:
			push_error("Node niet gevonden: %s" % btn_name)

	# Startwaarden
	$vraag4.visible = false
	$hidevraag4.visible = false
	$hint4.visible = false
	$hidehint4.visible = false
	
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


# --- Vraag 4 functionaliteit ---
func _on_showvraag4_pressed():
	$vraag4.visible = true
	$hidevraag4.visible = true

func _on_hidevraag4_pressed():
	$vraag4.visible = false
	$hidevraag4.visible = false


# --- Hint 4 functionaliteit ---
func _on_showhint4_pressed():
	Events.use_hint("room4")
	$hint4.visible = true
	$hidehint4.visible = true

func _on_hidehint4_pressed():
	$hint4.visible = false
	$hidehint4.visible = false


# --- Getal-knoppen functionaliteit ---
func _on_getal_pressed(number, button):
	# Zet de aangeklikte knop uit zodat hij niet opnieuw gebruikt wordt
	button.disabled = true

	# Voeg toe als dit getal nog niet in de lijst staat
	if number not in clicked_numbers:
		clicked_numbers.append(number)

	print("Geklikte nummers:", clicked_numbers)

	# Als alle 12 getallen geklikt zijn → volgende scene
	if clicked_numbers.size() == total_numbers:
		_change_to_next_scene()


func _change_to_next_scene():
	print("Alle getallen aangeklikt → Naar volgende scene.")
	TimeTracker.end_scene()
	get_tree().change_scene_to_file("res://scenes/room51.tscn")
