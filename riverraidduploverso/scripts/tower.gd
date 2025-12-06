extends CharacterBody2D

var screen : Vector2
var first_target: Vector2

enum State { PATROL, STRIKE, DYING }

var state: State = State.PATROL

@onready var player: Node2D = get_tree().current_scene.get_node('Player')

@onready var gun: Node2D = $Gun
@onready var MissileScene: PackedScene = preload("res://scenes/missile.tscn")

@export var detect_dist_x: float = 80.0   # largura da “coluna”
@export var detect_dist_y: float = 850.0  # alcance vertical

@export var shoot_cooldown: float = 1.5

var shoot_timer: float = 0.0
var shot: bool = false

func _ready() -> void:
	screen = get_viewport_rect().size
	first_target = Vector2.ZERO
	
func _physics_process(delta: float) -> void:
	match state:
		State.PATROL:
			_process_patrol(delta)
			_check_player_in_sight()
		State.STRIKE:
			_process_strike(delta)
		State.DYING:
			_process_dying()
		_: _process_patrol(delta)

func _process_patrol(delta: float) -> void:
	position.y += get_parent().get_parent().SPEED * delta
	
func _process_strike(delta: float) -> void:
	
	if shoot_timer == 0.0 and not shot and first_target != Vector2.ZERO:
		var missile := MissileScene.instantiate()
		missile.global_position = gun.global_position
		
		# mira na POSIÇÃO ATUAL do player (no momento do disparo)
		missile.target_position = first_target
		
		get_tree().current_scene.add_child(missile)
		
		shoot_timer = shoot_cooldown
		
	shoot_timer -= delta
	if shoot_timer <= 0.0:
		shot = true
		state = State.PATROL

func _process_dying() -> void:
	queue_free()

func take_damage() -> void:
	state = State.DYING
	
func _check_player_in_sight() -> void:
	if player == null:
		return
		
	# torre está acima do player
	var dx = abs(player.global_position.x - global_position.x)
	var dy = abs(global_position.y - player.global_position.y)
	
	# dy > 0 => player abaixo da torre
	if dx <= detect_dist_x and dy > 0 and dy <= detect_dist_y:
		# entra no estado de disparo'
		if state != State.STRIKE:
			first_target = player.global_position
			state = State.STRIKE
			shoot_timer = 0.0
