extends Control

@onready var showhint51 = $showhint51
@onready var hint51 = $hint51

func _ready():
	
	TimeTracker.start_scene("room51")

	
	var dialogue_res = preload("res://dialogue/dialogueroom51.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_res, "startdialoguefiveone")

	# Alles standaard onzichtbaar
	$hint51.visible = false
	$hidehint51.visible = false

	$informatie51.visible = false
	$hideinformatie51.visible = false

	# Buttons koppelen
	$showhint51.pressed.connect(_on_show_hint_51)
	$hidehint51.pressed.connect(_on_hide_hint_51)

	$showinformatie51.pressed.connect(_on_show_informatie_51)
	$hideinformatie51.pressed.connect(_on_hide_informatie_51)
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


# --- Hint 51 ---
func _on_show_hint_51():
	Events.use_hint("room51")
	$hint51.visible = true
	$hidehint51.visible = true

func _on_hide_hint_51():
	$hint51.visible = false
	$hidehint51.visible = false


# --- Informatie 51 ---
func _on_show_informatie_51():
	$informatie51.visible = true
	$hideinformatie51.visible = true

	# LineEdit moet verdwijnen
	$antwoord51.visible = false


func _on_hide_informatie_51():
	$informatie51.visible = false
	$hideinformatie51.visible = false

	# LineEdit komt terug
	$antwoord51.visible = true



# --- Codecontrole ---
var codes := ["377459"]

func _on_antwoord_51_text_submitted(password: String) -> void:
	if password not in codes:
		$antwoord51.clear()
		return
	else:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room52.tscn")
