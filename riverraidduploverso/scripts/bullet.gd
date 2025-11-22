extends Area2D

const enemy_ship := preload("res://scripts/ship.gd")
const enemy_chopper := preload("res://scripts/chopper.gd")

const speed: float = 500.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	
	# Todo projétil vai "pra cima"
	position.y -= speed * delta
	
	if position.y < -32:  # fora da tela, deve tirar objeto da fila
		queue_free()

func _on_body_entered(body: Node) -> void:
	#primeira versao do dano no inimigo
	'if body is enemy_ship:
		print("dano no navio")
		# dano no inimigo
		# destrói o inimigo
		body.queue_free()
		# destrói o tiro
		queue_free()
	if body is enemy_chopper:
		print("dano no helicoptero")
		# dano no inimigo
		# destrói o inimigo 
		body.queue_free()
		# destrói o tiro
		queue_free() '
	# mudando a responsabilidade de morrer para o inimigo
	# tank_damage() -> muda o estado do inimigo
	if body.has_method("take_damage"):
		# mudando o estado do inimigo
		body.take_damage()
		# elimininando o tiro
		queue_free()
