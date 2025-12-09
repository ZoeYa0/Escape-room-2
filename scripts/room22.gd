extends Control


@onready var lampen_button = $lampenverbinden
@onready var lampen_sprite = $lampenverbonden

@onready var schakelaarsluit_button = $schakelaarsluiten
@onready var grijs_sprite = $grijs
@onready var schakelaargesloten_sprite = $schakelaargesloten

@onready var atov_button = $atov
@onready var ampere_label = $ampere
@onready var volt_label = $volt

var start_time = 0

func _ready():
	
	Events.current_room = 2
	start_time = Time.get_ticks_msec()
	#FORCING pointing hand
	for node in get_tree().get_nodes_in_group("Buttons"):
		node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	lampen_sprite.visible = false
	grijs_sprite.visible = false
	schakelaargesloten_sprite.visible = false
	
	volt_label.visible = false
	ampere_label.visible = true

func _process(_delta):
	Events.rooms["room2"]["time"] += (Time.get_ticks_msec() - start_time) / 1000.0


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


func _check_conditions():
	if lampen_sprite.visible \
	and schakelaargesloten_sprite.visible \
	and volt_label.visible:
		get_tree().change_scene_to_file("res://scenes/room3.tscn")
