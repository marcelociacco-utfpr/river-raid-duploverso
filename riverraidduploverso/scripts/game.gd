extends Node2D

class_name Controller

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

@export var worlds: Array[World]
@export var current: int = 0
@onready var player := $Player

func _ready() -> void:
	print("Vidas atuais:", Global.lives)
	_set_collision_blue()

# SOLUCAO APRESENTADA POR GUSTAVO HENRIQUE CARDOSO DE ARAUJO
func _process(delta: float) -> void:	
	if Input.is_action_just_pressed("change"):
		worlds[current].visible = false
		
		current+=1
		if current >= worlds.size():
			current = 0
			
		worlds[current].visible = true
	
		if current == 0:
			_set_collision_blue()
		else:
			_set_collision_purple()
			

func add_score(amount: int) -> void:
	Global.score += amount
	print("PONTOS: ",Global.score)
	
func add_fuel(amount: int) -> void:
	Global.fuel += amount
	
func remove_fuel(amount: int) -> void:
	Global.fuel -= amount
	if Global.fuel > 0:
		print("FUEL: ",Global.fuel)
	else:
		get_tree().paused = true
	
func remove_life() -> void:
	Global.lives -= 1
	if Global.lives > 0:
		print("VIDAS: ",Global.lives)
		get_tree().reload_current_scene()
	else:
		get_tree().paused = true

func _set_collision_blue() -> void:
	player.set_collision_mask_value(2, true)
	player.set_collision_mask_value(3, false)
	player.set_collision_mask_value(4, true)
	player.set_collision_mask_value(5, true)
	player.set_collision_mask_value(7, true)
	player.set_collision_mask_value(8, false)
	player.set_collision_mask_value(9, false)
	player.get_node("hitbox").set_collision_mask_value(4, true)
	player.get_node("hitbox").set_collision_mask_value(5, true)
	player.get_node("hitbox").set_collision_mask_value(7, true)
	player.get_node("hitbox").set_collision_mask_value(8, false)
	player.get_node("hitbox").set_collision_mask_value(9, false)
	player.setShoot(true)
	
func _set_collision_purple() -> void:
	player.set_collision_mask_value(2, false)
	player.set_collision_mask_value(3, true)
	player.set_collision_mask_value(4, false)
	player.set_collision_mask_value(5, false)
	player.set_collision_mask_value(7, false)
	player.set_collision_mask_value(8, true)
	player.set_collision_mask_value(9, true)
	player.get_node("hitbox").set_collision_mask_value(4, false)
	player.get_node("hitbox").set_collision_mask_value(5, false)
	player.get_node("hitbox").set_collision_mask_value(7, false)
	player.get_node("hitbox").set_collision_mask_value(8, true)
	player.get_node("hitbox").set_collision_mask_value(9, true)
	player.setShoot(false)
