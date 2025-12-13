extends Node2D
signal puzzle_solved
var start_point: Button = null
var dragging := false
var temp_line: Line2D
var connections_made := {}
var offset = Vector2(5.0,5.0)
@onready var rightanswer_952192: AudioStreamPlayer = $"../../Audio/Rightanswer952192"

const SOLUTIONS = {
	"5": "6",
	"4": "18",
	"12": "17",
	"23": "26"
}

func _ready():
	add_to_group("puzzle_controller")

	#temporary dragging line
	temp_line = Line2D.new()
	temp_line.width = 4
	temp_line.default_color = Color(1, 1, 1, 0.7)
	add_child(temp_line)


func connection_point_pressed(point: Button):
	# First click
	if start_point == null:
		start_point = point
		dragging = true

		temp_line.clear_points()
		temp_line.add_point(point.global_position)
		temp_line.add_point(point.global_position)

		return

	# Second click
	dragging = false
	temp_line.clear_points()

	_try_connect(start_point, point)
	start_point = null


func _process(delta):
	if dragging and temp_line.get_point_count() == 2:
		temp_line.set_point_position(1, get_global_mouse_position())
func _try_connect(a: Button, b: Button):
	var id1 = a.id
	var id2 = b.id

	if SOLUTIONS.get(id1) == id2 or SOLUTIONS.get(id2) == id1:
		print("Correct connection:", id1, "->", id2)

		connections_made[id1] = id2
		connections_made[id2] = id1

		_draw_wire(a.global_position+offset, b.global_position+offset)
		#permanent wire
		rightanswer_952192.play()
		if _is_puzzle_solved():
			print("🎉 PUZZLE SOLVED!")
			puzzle_solved.emit()

	else:
		print("Wrong connection:", id1, "->", id2)
		Events.rooms["room2"]["wrong"] += 1
		
func _is_puzzle_solved() -> bool:
	for key in SOLUTIONS.keys():
		if not connections_made.has(key):
			return false
	return true

func _draw_wire(a_pos: Vector2, b_pos: Vector2):
	var line := Line2D.new()
	line.width = 6
	line.default_color = Color.GREEN
	add_child(line)
	line.add_point(a_pos)
	line.add_point(b_pos)
