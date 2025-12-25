extends Node2D
@onready var bg: ColorRect = $Bg
@onready var hide_hint: Button = $HideHint
@onready var label: Label = $Label
@onready var actual_hint: Label = $ActualHint
@onready var _2_answer: Sprite2D = $"2Answer"


func _on_show_hint_pressed() -> void:
	visible = true
	_2_answer.visible = false
	match Events.current_room:
		1:
			Events.rooms["room1"]["hints"] += 1
			match Events.rooms["room1"]["hints"]:
				1:
					actual_hint.text = tr("HINTS_1.1")
				2:
					actual_hint.text = tr("HINTS_1.2")
		2:
			if Events.room2_part2 == false and Events.rooms["room2"]["hints"] < 2:
				Events.rooms["room2"]["hints"] += 1
			elif Events.room2_part2:
				Events.rooms["room2"]["hints"] += 1
			match Events.rooms["room2"]["hints"]:
				1:
					actual_hint.text = tr("HINTS_2.1")
				2:
					actual_hint.text = tr("HINTS_2.2")
				3:
					actual_hint.text = tr("HINTS_2.3")
				4:
					$"2Answer".visible = true
		3:
			Events.rooms["room3"]["hints"] += 1
			match Events.rooms["room3"]["hints"]:
				1:
					actual_hint.text = tr("HINTS_3.1")
				2:
					actual_hint.text = tr("HINTS_3.2")
				3:
					actual_hint.text = tr("HINTS_3.3")
		4:
			Events.rooms["room4"]["hints"] += 1
			match Events.rooms["room4"]["hints"]:
				1:
					actual_hint.text = tr("HINTS_4.1")
				2:
					actual_hint.text = tr("HINTS_4.2")
		5:
			if Events.room5_part2 == false and Events.rooms["room5"]["hints"] < 3:
				Events.rooms["room5"]["hints"] += 1
			elif Events.room5_part2:
				Events.rooms["room5"]["hints"] += 1
			match Events.rooms["room5"]["hints"]:
				
				1:
					actual_hint.text = tr("HINTS_5.1")
				2:
					actual_hint.text = tr("HINTS_5.2")
				3:
						actual_hint.text = tr("HINTS_5.3")
				4:
					actual_hint.text = tr("HINTS_5.4")
				5:
					actual_hint.text = tr("HINTS_5.5")
				6:
					actual_hint.text = tr("HINTS_5.6")
					


func _on_hide_hint_pressed() -> void:
	visible = false
	$"2Answer".visible = false
