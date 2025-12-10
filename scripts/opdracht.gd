extends Control

@export_multiline var instruction_text: String
@export var requires_input: bool = false
@export var answer: String

func _ready():
	# Allow this node to receive input first
	set_process_unhandled_input(true)
	visible = false
	$Label.text = instruction_text
	$LineEdit.visible = requires_input
	
	#await get_tree().process_frame
	#minimum_size_changed()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		# Check if mouse is inside this node's rect
		if !get_global_rect().has_point(get_global_mouse_position()):
			hide()  # or queue_free()
		


func _on_show_opdracht_pressed() -> void:
	visible = true
	#if Events.current_room != 2:
		#$Label.text = tr("OPDRACHT_" + str(Events.current_room))

func _on_hide_opdracht_pressed() -> void:
	visible = false
