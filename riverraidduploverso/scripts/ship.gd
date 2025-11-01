extends CharacterBody2D

# ainda não fiz balanceamento da velocidade final do navio
const SPEED := 100.0
var direction := 1
var screen : Vector2

func _ready() -> void:
	screen = get_viewport_rect().size
	position.x = 16*5
	
func _physics_process(delta: float) -> void:
	position.x += direction * SPEED * delta

	# bate nas margens e volta
	if position.x <= 16*5:
		position.x = 16*5
		direction = 1
	elif position.x >= screen.x-64 - 16*5:
		position.x = screen.x-64 - 16*5
		direction = -1
