extends CharacterBody2D

const enemy_ship := preload("res://scripts/ship.gd")
const enemy_chopper := preload("res://scripts/chopper.gd")

# ainda não localizei a velocidade ideal
const SPEED := 500.0

# preciso balancear melhor o tempo de espera
var time_wait := 0.5
var time_fire := 0.0

enum State { IDLE, MOVING, CRASHING, DEAD }
enum ShootState { READY, FIRING, COOLDOWN }

var state: State = State.IDLE
var shoot_state: ShootState = ShootState.READY

# trazer o marcador (onde começa o tiro) para codigo
@onready var gun: Node2D = $Gun
# trazer a cena da bala para o codigo
@onready var BulletScene: PackedScene = preload("res://scenes/bullet.tscn")

func _ready():
	# posicionar o jogador sempre na parte debaixo da tela
	# começar o eixo x no centro da tela, igual ao jogo original
	var screen = get_viewport_rect().size
	global_position = Vector2(
		screen.x / 2,
		screen.y * 0.95
	)
	
'''func _physics_process(delta: float) -> void:
	
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
		time_fire = time_wait'''

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			_process_move()
		State.MOVING:
			_process_move()
		State.CRASHING:
			_process_crashing()
		State.DEAD: 
			_process_dead()
	
	_process_shoot(delta)

func _process_move() -> void:
	var dir := Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
		
	if dir.x == 0:
		state = State.IDLE
	else:
		state = State.MOVING

	velocity.x = dir.x * SPEED
	move_and_slide()
	
func _process_shoot(delta: float) -> void:
	
	match shoot_state:

		ShootState.READY:
			if Input.is_action_pressed("fire"):
				_shoot()
				shoot_state = ShootState.FIRING

		ShootState.FIRING:
			# assim que dispara, entra no cooldown
			time_fire = time_wait
			shoot_state = ShootState.COOLDOWN

		ShootState.COOLDOWN:
			time_fire -= delta
			if time_fire <= 0:
				shoot_state = ShootState.READY

func _shoot() -> void:
	# instanciar a cena bala(tiro)
	var bullet := BulletScene.instantiate()
	# posição global da bala, deve ser igual a da gun, que é o marcador no topo
	# meio da nave, isso faz com que o tiro sempre comece relacionado a posição
	# da nave.
	bullet.global_position = gun.global_position
	get_tree().current_scene.add_child(bullet)

func _on_hitbox_body_entered(body: Node2D) -> void:
	# funcionalidade retirada e adaptada do video 
	# https://youtu.be/McdCtvT-HJI?si=bko_chv7ZEx3BPdc
	if body is enemy_ship or body is enemy_chopper:
		state = State.CRASHING
				
func _process_crashing() -> void:
	velocity = Vector2.ZERO
	move_and_slide()

	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.1)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.1)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.1)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.1)
	
	state = State.DEAD
	
func _process_dead() -> void:
	velocity = Vector2.ZERO
	move_and_slide()
	
	$hitbox.monitoring = false
	$hitbox.monitorable = false
	
	self.modulate = Color(1,1,1,0)
	await get_tree().create_timer(0.2).timeout
	get_tree().current_scene.remove_life()
