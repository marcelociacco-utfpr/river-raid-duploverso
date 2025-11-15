extends CharacterBody2D

# ainda não fiz balanceamento da velocidade final do navio
const SPEED := 150.0
const TILE := 16
var direction := 1
var screen : Vector2

func _ready() -> void:
	screen = get_viewport_rect().size
	position.x = TILE*5
	position.y = TILE*10
	
func _physics_process(delta: float) -> void:
	position.x += direction * SPEED * delta
	position.y += get_parent().get_parent().SPEED * delta

	# bate nas margens e volta
	if position.x <= TILE*5:
		position.x = TILE*5
		direction = 1
	elif position.x >= screen.x-32 - TILE*5:
		position.x = screen.x-32 - TILE*5
		direction = -1
