# codigo criado pelo chatGPT
# adaptei para Combustível o código gerado para inimigos

extends Node2D

@export var bridge_scene: PackedScene

@export var min_spawn_time: float = 1.5
@export var max_spawn_time: float = 3.5

@export var spawn_y: float = -32.0

var rng := RandomNumberGenerator.new()
var time_to_next: float

func _ready():
	rng.randomize()
	_reset_timer()

func _process(delta):
	time_to_next -= delta
	if time_to_next <= 0.0:
		_spawn_bridge()
		_reset_timer()

func _reset_timer():
	time_to_next = rng.randf_range(min_spawn_time, max_spawn_time)

func _spawn_bridge():
	var scene: PackedScene
	if rng.randf() < 0.3:
		scene = bridge_scene
	else:
		return
	
	var bridge := scene.instantiate()
	bridge.global_position = Vector2(
		0,
		spawn_y
	)
	add_child(bridge)
