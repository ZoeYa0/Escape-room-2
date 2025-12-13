extends Control

var clicked_numbers := []
var total_numbers := 12
var start_time = 0
var dialogue_res = preload("res://dialogue/dialogueroom4.dialogue")
@onready var rightanswer_952192: AudioStreamPlayer = $Audio/Rightanswer952192
@onready var wronganswer_37702: AudioStreamPlayer = $Audio/Wronganswer37702

func _ready():
	Events.current_room = 4
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand not in this scene!!
	#for node in get_tree().get_nodes_in_group("Buttons"):
		#node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	
	DialogueManager.show_dialogue_balloon(dialogue_res, "start")


	for i in range(1, total_numbers + 1):
		var btn_name := "getal%d" % i
		if has_node(btn_name):
			var button = get_node(btn_name)
			button.pressed.connect(_on_getal_pressed.bind(i, button))
			#buttons are connected via script.
		else:
			push_error("Node niet gevonden: %s" % btn_name)

	
	
func _process(delta):
	Events.rooms["room4"]["time"] = (Time.get_ticks_msec() - start_time) / 1000.0


func _on_getal_pressed(number, button):
	

	# Voeg toe als dit getal nog niet in de lijst staat
	if number not in clicked_numbers:
		clicked_numbers.append(number)
		rightanswer_952192.play()
	else:
		wronganswer_37702.play()
		Events.rooms["room4"]["wrong"] += 1
		
	# Zet de aangeklikte knop uit zodat hij niet opnieuw gebruikt wordt
	button.disabled = true
	print("Geklikte nummers:", clicked_numbers)

	# Als alle 12 getallen geklikt zijn → volgende scene
	if clicked_numbers.size() == total_numbers:
		get_tree().change_scene_to_file("res://scenes/room51.tscn")


func _on_wrong_area_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
