extends Control

#---------------------ROOM 4------------
var clicked_numbers := []        # Lijst met aangeklikte nummers
var total_numbers := 12          # Totaal aantal getalknoppen
var start_time = 0

func _ready():
	Events.current_room = 4
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	var dialogue_res = preload("res://dialogue/dialogueroom4.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")


	for i in range(1, total_numbers + 1):
		var btn_name := "getal%d" % i
		if has_node(btn_name):
			var button = get_node(btn_name)
			button.pressed.connect(_on_getal_pressed.bind(i, button))
		else:
			push_error("Node niet gevonden: %s" % btn_name)

	$vraag4.visible = false
	$hidevraag4.visible = false

	
	
func _process(delta):
	Events.rooms["room4"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


# --- Vraag 4 functionaliteit ---
func _on_showvraag4_pressed():
	$vraag4.visible = true
	$hidevraag4.visible = true

func _on_hidevraag4_pressed():
	$vraag4.visible = false
	$hidevraag4.visible = false


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
