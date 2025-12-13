extends Panel
@onready var wronganswer_37702: AudioStreamPlayer = $"../Audio/Wronganswer37702"




func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
		var clicked_button = null
		for btn in get_tree().get_nodes_in_group("Buttons"):
			if btn.get_global_rect().has_point(mouse_pos):
				clicked_button = btn
				break

		# If no button was under the click → wrong
		if clicked_button == null:
			wronganswer_37702.play()
			Events.rooms["room4"]["wrong"] += 1
