# Scenes

## 📱 Resolution 
- Set the base window width to ``720`` and window height to ``1280``.
- If you're targeting high-end devices primarily, set the base window width to ``1080`` and window height to ``1920`` (crisper visuals & higher memory usage).
- Set Display > Window > Handheld > Orientation to ``portrait``.
- Set the **stretch** >  **mode** to ``canvas_items``.
- Set the **stretch** > **aspect** to ``expand``. This allows for supporting multiple aspect ratios and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html#mobile-game-in-portrait-mode)

## 👍 Best Practices 
- tralala

## 🧠 Singleton (Autoload) 
Godot's scene system, while powerful and flexible, has a drawback: there is no method for storing information that is needed by more than one scene. And thats where singleton that runs via autoload comes in.

Perfect for things like player's score or inventory
- [Offical Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html#doc-singletons-autoload)

## 🎯 Signals 
Signal is like “Hey! Something just happened!” …and letting other parts of your game decide what to do about it.

- Perfect for things that happen often like shooting, getting hit, dying, etc. 
- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/instancing_with_signals.html#shooting-example)

## 📦 PackedScene
todo

## 🎃 Transitions 
### Basic change between scenes
Changing current scene via button:

	extends Node2D
	
	func _on_button_pressed() -> void:
		_change_scene_01()
	
	func _change_scene_01():
		get_tree().change_scene_to_file("res://scene/scene01.tscn")


- Just make sure to properly set the button first:

- <img width="209" alt="image" src="https://github.com/user-attachments/assets/6e05aa06-754b-47d8-96cc-96187d17839d" />


- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/scene_tree.html#changing-current-scene)


### Fade between the scenes
Let`s start with some cool transitions between scenes:

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
		get_tree().change_scene_to_file("res://scene/main.tscn")

  - Just make sure to properly set the button & the CanvasLayer along with ColorReact:

  - <img width="199" alt="image" src="https://github.com/user-attachments/assets/ab4337dd-ffcc-4515-af6c-4d29d91e069e" />

