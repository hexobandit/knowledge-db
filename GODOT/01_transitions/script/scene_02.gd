extends Node2D

@onready var _animated_brocco =$CharacterBody2D/AnimatedSprite2D

func _process(_delta):
	_animated_brocco.play("default")
