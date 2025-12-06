extends Area2D

const speed: float = 500.0
var target_position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if target_position != Vector2.ZERO:
		direction = (target_position - global_position).normalized()
	else:
		direction = Vector2(0, 1)  #desce reto

func _physics_process(delta: float) -> void:
	
	if direction == Vector2.ZERO:
		return
		
	position += direction * speed * delta
	
	if position.y > 960:  # fora da tela, deve tirar objeto da fila
		queue_free()
