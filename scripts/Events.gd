extends Node

var current_room := 1
var rooms = {
	"room1": {"time": 0, "wrong": 0, "hints": 0},
	"room2": {"time": 0, "wrong": 0, "hints": 0},
	"room3": {"time": 0, "wrong": 0, "hints": 0},
	"room4": {"time": 0, "wrong": 0, "hints": 0},
	"room5": {"time": 0, "wrong": 0, "hints": 0},
}
#-----------ROOM 1 sun

#-----------ROOM 2 ph

#-----------ROOM 3 virus

#-----------ROOM 4 computer
#-----------ROOM 5


## Houd bij of hints gebruikt zijn
#var hints_used = {
	#"room1": false,
	#"room2": false,
	#"room22": false,
	#"room3": false,
	#"room4": false,
	#"room51": false,
	#"room52": false
#}
#
## Markeer een hint als gebruikt
#func use_hint(hint_name: String) -> void:
	#if hint_name in hints_used:
		#hints_used[hint_name] = true
#
## Tel het aantal gebruikte hints voor een groep
#func count_group(group: String) -> int:
	#match group:
		#"room1":
			#return 1 if hints_used["room1"] else 0
		#"room2_group":
			#var total = 0
			#if hints_used["room2"]: total += 1
			#if hints_used["room22"]: total += 1
			#return total
		#"room3":
			#return 1 if hints_used["room3"] else 0
		#"room4":
			#return 1 if hints_used["room4"] else 0
		#"room5_group":
			#var total = 0
			#if hints_used["room51"]: total += 1
			#if hints_used["room52"]: total += 1
			#return total
		#_:
			#return 0
