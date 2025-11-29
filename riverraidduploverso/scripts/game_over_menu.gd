extends CanvasLayer

@onready var game_manager := get_parent()
@onready var score_label = $Panel/VBoxContainer/ScoreLabel

func _ready() -> void:
	$Panel/VBoxContainer/RetryButton.connect("pressed", Callable(self, "_on_retry_pressed"))
	$Panel/VBoxContainer/MenuButton.connect("pressed", Callable(self, "_on_menu_pressed"))
	$Panel/VBoxContainer/QuitButton.connect("pressed", Callable(self, "_on_quit_pressed"))

func show_game_over(final_score: int) -> void:
	score_label.text = "Pontos: %d" % final_score
	show()

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	game_manager.set_state(game_manager.GameState.MENU)

func _on_quit_pressed() -> void:
	get_tree().quit()
