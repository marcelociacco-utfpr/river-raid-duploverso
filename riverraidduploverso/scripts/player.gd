extends CharacterBody2D

# ainda não localizei a velocidade ideal
const SPEED := 500.0

# preciso balancear melhor o tempo de espera
var time_wait := 0.5
var time_fire := 0.0

# trazer o marcador (onde começa o tiro) para codigo
@onready var gun: Node2D = $Gun
# trazer a cena da bala para o codigo
@onready var BulletScene: PackedScene = preload("res://scenes/bullet.tscn")

func _ready():
	# posicionar o jogador sempre na parte debaixo da tela
	# começar o eixo x no centro da tela, igual ao jogo original
	var tela = get_viewport_rect().size
	global_position = Vector2(
		tela.x / 2,
		tela.y * 0.95
	)
	
func _physics_process(delta: float) -> void:
	
	# direcao horizontal de movimento
	# -1 anda para esquerda
	# +1 anda para direita
	var dir := Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1

	velocity.x = dir.x * SPEED
	move_and_slide()
	
	# meu primeiro código foi este:
	# atirava sem parar
	# if Input.is_action_pressed("fire") :
	# _shoot()
	
	# código aprensentado pelo chatgpt como resolução
	# aguardar um tempo para dar próximo tiro.
	time_fire = max(time_fire - delta, 0.0)
	if Input.is_action_pressed("fire") and time_fire <= 0.0:
		_shoot()
		time_fire = time_wait

func _shoot() -> void:
	# instanciar a cena bala(tiro)
	var bullet := BulletScene.instantiate()
	# posição global da bala, deve ser igual a da gun, que é o marcador no topo
	# meio da nave, isso faz com que o tiro sempre comece relacionado a posição
	# da nave.
	bullet.global_position = gun.global_position
	get_tree().current_scene.add_child(bullet)
