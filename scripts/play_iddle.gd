extends CharacterBody2D

@onready var sprite: = $AnimatedSprite2D

func _on_chegada_animation_finished(anim_name):
	sprite.play("iddle")
