extends Button

@export var id: String

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	var controller = get_tree().get_first_node_in_group("puzzle_controller")
	controller.connection_point_pressed(self)
