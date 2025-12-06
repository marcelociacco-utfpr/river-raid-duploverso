# codigo criado pelo chatGPT
# adaptei para Combustível o código gerado para inimigos

extends Node2D

@export var tower_scene: PackedScene

@export var min_spawn_time: float = 1.5
@export var max_spawn_time: float = 3.5

@export var left_limit: float = 80.0
@export var right_limit: float = 544.0 - 80.0
@export var spawn_y: float = -32.0

var rng := RandomNumberGenerator.new()
var time_to_next: float

func _ready():
	rng.randomize()
	_reset_timer()

func _process(delta):
	time_to_next -= delta
	if time_to_next <= 0.0:
		_spawn_tower()
		_reset_timer()

func _reset_timer():
	time_to_next = rng.randf_range(min_spawn_time, max_spawn_time)

func _spawn_tower():
	var scene: PackedScene
	if rng.randf() < 0.7:
		scene = tower_scene
	else:
		return
	
	var tower := scene.instantiate()
	tower.global_position = Vector2(
		rng.randf_range(left_limit, right_limit),
		spawn_y
	)
	add_child(tower)
