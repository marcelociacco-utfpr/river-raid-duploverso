extends Area2D

var speed: float = 680.0
var damage: int = 10

func _physics_process(delta: float) -> void:
	
	# Todo projétil vai "pra cima"
	position.y -= speed * delta
	
	if position.y < -32:  # fora da tela, deve tirar objeto da fila
		queue_free()
