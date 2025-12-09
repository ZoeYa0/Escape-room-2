extends Control

@onready var total: Label = $Total
@onready var title: Label = $Title

var total_time := 0
var total_wrong := 0
var total_hints := 0

func _ready() -> void:
	for room_name in Events.rooms:
		var stats = Events.rooms[room_name]

		var label: Label = $Labels.get_node(room_name)
		#label.text = tr('UI_SCORE') % [
			#stats.time, stats.wrong, stats.hints
		#]
		total_time += stats.time
		total_wrong += stats.wrong
		total_hints += stats.hints
		label.text = tr("UI_SCORE").format({
	"time": stats.time,
	"wrong": stats.wrong,
	"hints": stats.hints
})

	#total.text = "Total stats:\n
	#Total Time: %d
	#Total Wrong attempts: %d
	#Total Hints: %d" % [
	#total_time, total_wrong, total_hints
	#
	#]#huh \n gives double breaks
	total.text = tr("UI_TOT_SCORE") % [
	total_time, total_wrong, total_hints
	
	]#huh \n gives double breaks


@export var hue = 0.0

func _process(delta: float) -> void:
	title.modulate = Color.from_hsv(hue, 1.0, 1.0, 1.0)
	if hue < 1.0:
		hue += 0.001
	else:
		hue = 0.0


## Labels voor tijden
#@onready var tijd1 = $tijd1
#@onready var tijd2 = $tijd2
#@onready var tijd3 = $tijd3
#@onready var tijd4 = $tijd4
#@onready var tijd5 = $tijd5
#
## Labels voor gebruikte hints
#@onready var hint1 = $hint1
#@onready var hint2 = $hint2
#@onready var hint3 = $hint3
#@onready var hint4 = $hint4
#@onready var hint5 = $hint5
#
#func _ready():
	## --- Tijden in MM:SS.ms ---
	#tijd1.text = "Kamer 1: %s" % format_time(TimeTracker.group_times["room1"])
	#tijd2.text = "Kamer 2: %s" % format_time(TimeTracker.group_times["room2_group"])
	#tijd3.text = "Kamer 3: %s" % format_time(TimeTracker.group_times["room3"])
	#tijd4.text = "Kamer 4: %s" % format_time(TimeTracker.group_times["room4"])
	#tijd5.text = "Kamer 5: %s" % format_time(TimeTracker.group_times["room5_group"])
	#
	## --- Gebruikte hints ---
	#hint1.text = "Gebruikte hints: %d" % Events.count_group("room1")
	#hint2.text = "Gebruikte hints: %d" % Events.count_group("room2_group")
	#hint3.text = "Gebruikte hints: %d" % Events.count_group("room3")
	#hint4.text = "Gebruikte hints: %d" % Events.count_group("room4")
	#hint5.text = "Gebruikte hints: %d" % Events.count_group("room5_group")
#
## Hulpfunctie om seconden om te zetten naar MM:SS.ms
#func format_time(time_sec: float) -> String:
	#var minutes = int(time_sec / 60)
	#var seconds = int(time_sec) % 60
	#var milliseconds = int((time_sec - int(time_sec)) * 1000)
	#return "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
