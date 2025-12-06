extends CharacterBody2D

# ainda não fiz balanceamento da velocidade final do navio
var screen : Vector2

enum State { PATROL, DYING }

var state: State = State.PATROL

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
	position.y += get_parent().get_parent().SPEED * delta

func _process_dying() -> void:
	queue_free()

func take_damage() -> void:
	state = State.DYING
