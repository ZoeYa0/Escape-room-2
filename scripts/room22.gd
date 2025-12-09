extends Control

@onready var showhint22 = $showhint22
@onready var hint22 = $hint22

@onready var show_button = $showhint22
@onready var hide_button = $hidehint22
@onready var hint_sprite = $hint22

@onready var lampen_button = $lampenverbinden
@onready var lampen_sprite = $lampenverbonden

@onready var schakelaarsluit_button = $schakelaarsluiten
@onready var grijs_sprite = $grijs
@onready var schakelaargesloten_sprite = $schakelaargesloten

@onready var atov_button = $atov
@onready var ampere_label = $ampere
@onready var volt_label = $volt


func _ready():
	
	TimeTracker.start_scene("room22")

	
	hint_sprite.visible = false
	hide_button.visible = false
	lampen_sprite.visible = false
	grijs_sprite.visible = false
	schakelaargesloten_sprite.visible = false
	
	volt_label.visible = false
	ampere_label.visible = true

	show_button.pressed.connect(_on_showhint22_pressed)
	hide_button.pressed.connect(_on_hidehint22_pressed)
	lampen_button.pressed.connect(_on_lampenverbinden_pressed)
	schakelaarsluit_button.pressed.connect(_on_schakelaarsluiten_pressed)
	atov_button.pressed.connect(_on_atov_pressed)
	
func _process(delta):
	TimeTracker.update_elapsed()
	$TimerLabel.text = "Tijd: %.2f sec" % TimeTracker.current_elapsed


func _on_showhint22_pressed():
	Events.use_hint("room22")
	hint_sprite.visible = true
	hide_button.visible = true
	show_button.visible = false
	_check_conditions()


func _on_hidehint22_pressed():
	hint_sprite.visible = false
	hide_button.visible = false
	show_button.visible = true


func _on_lampenverbinden_pressed():
	lampen_sprite.visible = true
	_check_conditions()


func _on_schakelaarsluiten_pressed():
	grijs_sprite.visible = true
	schakelaargesloten_sprite.visible = true
	_check_conditions()


func _on_atov_pressed():
	ampere_label.visible = false
	volt_label.visible = true
	_check_conditions()


# ---------------------------------------------------------
#   CONDITIECHECK: GA NAAR NIEUWE SCENE ALS ALLES ZICHTBAAR IS
# ---------------------------------------------------------
func _check_conditions():
	if lampen_sprite.visible \
	and schakelaargesloten_sprite.visible \
	and volt_label.visible:
		TimeTracker.end_scene()
		get_tree().change_scene_to_file("res://scenes/room3.tscn")
