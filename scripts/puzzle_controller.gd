extends Node2D

var start_point: Node = null
var temp_line: Line2D
const SOLUTIONS = {
	'1':'2','2':'3'
}

func _ready():
	temp_line = $Line2D
	temp_line.clear_points()
	
func _process(_delta):
	if start_point:
		temp_line.set_point_position(1, get_global_mouse_position())

func on_connection_point_clicked(point: Node):
	if start_point == null:
		# first point selected
		start_point = point
		temp_line.add_point(point.global_position)
	else:
		# second point selected
		temp_line.add_point(point.global_position)
		_register_connection(start_point.id, point.id)
		start_point = null
		temp_line.clear_points()
		
func _register_connection(a: String, b: String):
	if SOLUTIONS.get(a) == b or SOLUTIONS.get(b) == a:
		print("Correct connection!")
		_draw_final_wire(a, b)
	else:
		print("Wrong connection!")
		
func _draw_final_wire(a_id: String, b_id: String):
	var a = get_node(a_id)
	var b = get_node(b_id)

	var line := Line2D.new()
	add_child(line)
	line.width = 6
	line.default_color = Color.GREEN
	line.add_point(a.global_position)
	line.add_point(b.global_position)
