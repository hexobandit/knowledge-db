# Scenes

## Resolution
- Set the base window width to ``720`` and window height to ``1280``.
- If you're targeting high-end devices primarily, set the base window width to ``1080`` and window height to ``1920`` (crisper visuals & higher memory usage).
- Set Display > Window > Handheld > Orientation to ``portrait``.
- Set the **stretch mode** to ``canvas_items``.
- Set the **stretch aspect** to ``expand``. This allows for supporting multiple aspect ratios and makes better use of tall smartphone displays (such as 18:9 or 19:9 aspect ratios).
- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html#mobile-game-in-portrait-mode)

## Best Practices
- tralala

## Singleton (Autoload)
Godot's scene system, while powerful and flexible, has a drawback: there is no method for storing information that is needed by more than one scene. And thats where singleton that runs via autoload comes in.

Perfect for things like player's score or inventory
- [Offical Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html#doc-singletons-autoload)

## Signal
Signal is like “Hey! Something just happened!” …and letting other parts of your game decide what to do about it.

- Perfect for things that happen often like shooting, getting hit, dying, etc.
- [Official Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/instancing_with_signals.html#shooting-example)


## Transitions 🎃
Let`s start with some cool transitions between scenes:

1. dd
2. 22
3. 33
4. 44


