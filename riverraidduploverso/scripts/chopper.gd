extends CharacterBody2D

# ainda não fiz balanceamento da velocidade final do helicoptero
const SPEED := 200.0
const TILE := 16
var direction := 1
var screen : Vector2

enum State { PATROL, DYING }

var state: State = State.PATROL
var points: int = 15

func _ready() -> void:
	screen = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:
	match state:
		State.PATROL:
			_process_patrol(delta)
		State.DYING:
			_process_dying()
		_: _process_patrol(delta)

func _process_patrol(delta: float) -> void:
	position.x += direction * SPEED * delta
	position.y += get_parent().get_parent().SPEED * delta

	# bate nas margens e volta
	if position.x <= TILE*5:
		position.x = TILE*5
		direction = 1
	elif position.x >= screen.x-32 - TILE*5:
		position.x = screen.x-32 - TILE*5
		direction = -1
		
func _process_dying() -> void:
	#acessar a cena principal que está rodando que é a GAME
	#alterar a pontuação
	get_tree().current_scene.add_score(points)
	queue_free()
	
func take_damage() -> void:
	state = State.DYING
