extends Panel

@export_multiline var instruction_text: String
@export var requires_input: bool = false
@export var answer_text: String
#@onready var mim_size = rect_size

func _ready():
	$InnerBox/Label.text = instruction_text
	$InnerBox/LineEdit.visible = requires_input
	if requires_input:
		$InnerBox/LineEdit.text = answer_text

func _on_LineEdit_text_changed(new_text: String) -> void:
	answer_text = new_text


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


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == answer_text:
		visible = false





func _on_close_pressed() -> void:
	visible = false
