extends Node2D

class_name Controller

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

@export var worlds: Array[World]
@export var current: int = 0

var fuel: int = 500

var state: GameState = GameState.MENU

@onready var world      = $World
@onready var hud        = $HUD
@onready var main_menu  = $MainMenu
@onready var pause_menu = $PauseMenu
@onready var game_over_menu = $GameOverMenu

func _ready() -> void:
	print("Vidas atuais:", Global.lives)
#	set_state(GameState.MENU)

func _process(delta: float) -> void:	
	if Input.is_action_just_pressed("change"):
		worlds[current].visible = false
		current+=1
		if current >= worlds.size():
			current = 0
		worlds[current].visible = true
			

func add_score(amount: int) -> void:
	Global.score += amount
	print("PONTOS: ",Global.score)
	#get_tree().current_scene.get_node("HUD").set_score(Global.score)
	
func add_fuel(amount: int) -> void:
	fuel += amount
	
func remove_fuel(amount: int) -> void:
	fuel -= amount
	if fuel > 0:
		print("FUEL: ",fuel)
		#get_tree().current_scene.get_node("HUD").set_fuel(fuel)
	else:
		get_tree().paused = true
	
func remove_life() -> void:
	Global.lives -= 1
	if Global.lives > 0:
		print("VIDAS: ",Global.lives)
		#get_tree().current_scene.get_node("HUD").set_lives(Global.lives)
		get_tree().reload_current_scene()
	else:
		#get_tree().current_scene.set_state(GameState.GAME_OVER)
		get_tree().paused = true
		
func set_state(new_state: GameState) -> void:
	state = new_state
	main_menu.hide()
	pause_menu.hide()
	hud.hide()
	
	match state:
		GameState.MENU:
			get_tree().paused = true
			main_menu.show()
			
		GameState.PLAYING:
			get_tree().paused = false
			hud.show()
				
		GameState.PAUSED:
			get_tree().paused = true
			hud.show()
			pause_menu.show()
			
		GameState.GAME_OVER:
			get_tree().paused = true

func _control(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match state:
			GameState.PLAYING:
				set_state(GameState.PAUSED)
			GameState.PAUSED:
				set_state(GameState.PLAYING)
