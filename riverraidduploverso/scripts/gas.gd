extends CharacterBody2D

func _ready() -> void:
	position.x = 240
	position.y = 450

func _physics_process(delta: float) -> void:
	position.y += get_parent().SPEED * delta
