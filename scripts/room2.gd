extends Control

@onready var showhint2 = $showhint2
@onready var hint2 = $hint2

# Nodes als variabelen voor makkelijk gebruik
var dialogue_label
var hint_sprite
var show_button
var hide_button

func _ready():
	
	TimeTracker.start_scene("room2")

	
	# Nodes ophalen
	dialogue_label = $dialoguemanager2
	hint_sprite = $hint2
	show_button = $showhint2
	hide_button = $hidehint2

	# De hint en hide-knop zijn standaard verborgen
	hint_sprite.visible = false
	hide_button.visible = false

	# Signalen verbinden
	show_button.pressed.connect(_on_showhint_pressed)
	hide_button.pressed.connect(_on_hidehint_pressed)

	# Dialogue laden en tonen
	var dialogue_res = preload("res://dialogue/dialogueroom2.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "startdialoguetwo")
	
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed

# Functie voor het tonen van hint
func _on_showhint_pressed():
	Events.use_hint("room2")
	hint_sprite.visible = true
	hide_button.visible = true
	show_button.visible = false  # knop verbergen terwijl hint zichtbaar is

# Functie voor het verbergen van hint
func _on_hidehint_pressed():
	hint_sprite.visible = false
	hide_button.visible = false
	show_button.visible = true  # knop weer tonen

# Antwoord invullen
var codes := ["92,86", "92.86", "92,86V", "92.86V", "92,86 V", "92.86 V", "92,86Volt", "92.86Volt", "92,86 Volt", "92.86 Volt", "92,86volt", "92.86volt", "92,86 volt", "92.86 volt"]

func _on_line_edit_text_submitted(password: String) -> void:
	if password not in codes:
		$antwoord2.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room22.tscn")
