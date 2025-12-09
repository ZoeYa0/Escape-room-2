extends Node

# Totale tijd per groep
var group_times = {
	"room1": 0.0,
	"room2_group": 0.0,  # room2 + room22
	"room3": 0.0,
	"room4": 0.0,
	"room5_group": 0.0   # room51 + room52
}

var current_group = ""
var scene_start_time = 0.0
var current_elapsed = 0.0
var running = false

# Start de timer voor een scene
func start_scene(scene_name: String):
	match scene_name:
		"room1":
			current_group = "room1"
		"room2", "room22":
			current_group = "room2_group"
		"room3":
			current_group = "room3"
		"room4":
			current_group = "room4"
		"room51", "room52":
			current_group = "room5_group"
		_:
			current_group = ""
	
	scene_start_time = Time.get_ticks_usec() / 1_000_000.0
	current_elapsed = 0.0
	running = true

# Stop de timer voor een scene
func end_scene():
	if current_group == "" or not running:
		return

	var end_time = Time.get_ticks_usec() / 1_000_000.0
	var duration = end_time - scene_start_time
	group_times[current_group] += duration

	running = false

# Update realtime timer (voor labels in de scene)
func update_elapsed():
	if running:
		current_elapsed = Time.get_ticks_usec() / 1_000_000.0 - scene_start_time
