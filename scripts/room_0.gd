extends Node2D


func _on_button_pressed() -> void:
	TranslationServer.set_locale("en")
	get_tree().change_scene_to_file("res://scenes/room1.tscn")


func _on_button_2_pressed() -> void:
	TranslationServer.set_locale("nl")
	get_tree().change_scene_to_file("res://scenes/room1.tscn")
