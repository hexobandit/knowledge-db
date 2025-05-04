# Scenes

## 📱 Resolution 
- Set the base window width to ``720`` and window height to ``1280``.
- If you're targeting high-end devices primarily, set the base window width to ``1080`` and window height to ``1920`` (crisper visuals & higher memory usage).
- Set Display > Window > Handheld > Orientation to ``portrait``.
- Set the **stretch mode** to ``canvas_items``.
- Set the **stretch aspect** to ``expand``. This allows for supporting multiple aspect ratios and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
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

Changing current scene (Define the function):

    func _my_level_was_completed():
	    get_tree().change_scene_to_file("res://levels/level2.tscn")

    func _on_button_pressed():
	    get_tree().change_scene_to_file("res://levels/level2.tscn")

- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/scene_tree.html#changing-current-scene)

Let`s start with some cool transitions between scenes:

### Fade between the scenes
NOT TESTED YET

    extends Control  # or Node2D, CanvasLayer, etc.
    
    @onready var fade_rect = $CanvasLayer/FadeRect
    @onready var tween = get_tree().create_tween()
    
    const NEXT_SCENE = preload("res://levels/level2.tscn")
    
    func _on_button_pressed():
    	fade_rect.visible = true
    	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)  # Fade to black in 1 second
    	tween.tween_callback(Callable(self, "_change_scene"))
    
    func _change_scene():
    	get_tree().change_scene_to_packed(NEXT_SCENE)
