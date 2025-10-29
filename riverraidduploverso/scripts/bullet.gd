extends Area2D

const speed: float = 500.0

func _physics_process(delta: float) -> void:
	
	# Todo projétil vai "pra cima"
	position.y -= speed * delta
	
	if position.y < -32:  # fora da tela, deve tirar objeto da fila
		queue_free()
