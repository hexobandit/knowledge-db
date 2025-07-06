extends Node2D

@onready var fade_rect := $CanvasLayer/ColorRect

func _ready():
	fade_rect.color = Color(0, 0, 0, 0) # black, fully transparent
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_button_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, 1.0)
	tween.tween_callback(Callable(self, "_change_scene_main"))
	
func _change_scene_main():
	get_tree().change_scene_to_file("res://scene/scene02.tscn")
