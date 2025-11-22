extends Area2D
# mudei para Area2D para facilitar a colisão, já que não será um inimigo
# não tem necessidade de ser um characterbody

enum State { FALLING, COLLECTED }

var state: State = State.FALLING

func _ready() -> void:
	position.x = 240
	position.y = 450
	body_entered.connect(_got_collected)

func _physics_process(delta: float) -> void:
	match state:
		State.FALLING:
			_process_falling(delta)
		State.COLLECTED:
			_process_collected()
		_: _process_falling(delta)

func _process_falling(delta: float) -> void:
	position.y += get_parent().SPEED * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _process_collected() -> void:
	print("colidiu com player")
	get_tree().current_scene.add_fuel(50)
	queue_free()
	
func _got_collected(body: Node) -> void:
	if body.name == "Player":
		state = State.COLLECTED
