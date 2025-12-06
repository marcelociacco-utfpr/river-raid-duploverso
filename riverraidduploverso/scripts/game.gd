extends Node2D

class_name Controller

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

@export var worlds: Array[World]
@export var current: int = 0
@onready var player := $Player

var fuel: int = 500

func _ready() -> void:
	print("Vidas atuais:", Global.lives)
	player.set_collision_mask_value(2, true)
	player.set_collision_mask_value(3, false)
	player.set_collision_mask_value(4, true)
	player.set_collision_mask_value(5, true)
	player.set_collision_mask_value(7, true)
	player.set_collision_mask_value(8, false)

# SOLUCAO APRESENTADA POR GUSTAVO HENRIQUE CARDOSO DE ARAUJO
func _process(delta: float) -> void:	
	if Input.is_action_just_pressed("change"):
		worlds[current].visible = false
		
		current+=1
		if current >= worlds.size():
			current = 0
			
		worlds[current].visible = true
	
		if current == 0:
			player.set_collision_mask_value(2, true)
			player.set_collision_mask_value(3, false)
			player.set_collision_mask_value(4, true)
			player.set_collision_mask_value(5, true)
			player.set_collision_mask_value(7, true)
			player.set_collision_mask_value(8, false)
			player.get_node("hitbox").set_collision_mask_value(4, true)
			player.get_node("hitbox").set_collision_mask_value(5, true)
			player.setShoot(true)
		else:
			player.set_collision_mask_value(2, false)
			player.set_collision_mask_value(3, true)
			player.set_collision_mask_value(4, false)
			player.set_collision_mask_value(5, false)
			player.set_collision_mask_value(7, false)
			player.set_collision_mask_value(8, true)
			player.get_node("hitbox").set_collision_mask_value(4, false)
			player.get_node("hitbox").set_collision_mask_value(5, false)
			player.setShoot(false)
			

func add_score(amount: int) -> void:
	Global.score += amount
	print("PONTOS: ",Global.score)
	
func add_fuel(amount: int) -> void:
	fuel += amount
	
func remove_fuel(amount: int) -> void:
	fuel -= amount
	if fuel > 0:
		print("FUEL: ",fuel)
	else:
		get_tree().paused = true
	
func remove_life() -> void:
	Global.lives -= 1
	if Global.lives > 0:
		print("VIDAS: ",Global.lives)
		get_tree().reload_current_scene()
	else:
		get_tree().paused = true
