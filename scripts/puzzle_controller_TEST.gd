extends Node2D
var start_point: Button = null

const SOLUTIONS = {
	"1": "2",
	"2": "6"
}

func _ready():
	add_to_group("puzzle_controller")

func connection_point_pressed(point: Button):
	if start_point == null:
		start_point = point
		return

	_try_connect(start_point, point)
	start_point = null


func _try_connect(a: Button, b: Button):
	var id1 = a.id
	var id2 = b.id

	if SOLUTIONS.get(id1) == id2 or SOLUTIONS.get(id2) == id1:
		print("Correct connection:", id1, "->", id2)
		_draw_wire(a.global_position, b.global_position)
	else:
		print("Wrong connection:", id1, "->", id2)
		
func _draw_wire(a_pos: Vector2, b_pos: Vector2):
	var line := Line2D.new()
	line.width = 5
	line.default_color = Color.GREEN
	add_child(line)
	line.add_point(a_pos)
	line.add_point(b_pos)
