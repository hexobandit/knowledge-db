extends Node2D

func _on_button_pressed() -> void:
	_change_scene_01()

func _change_scene_01():
	get_tree().change_scene_to_file("res://scene/scene01.tscn")
