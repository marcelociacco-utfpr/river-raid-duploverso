extends CanvasLayer

@onready var game_manager := get_parent()

func _ready() -> void:
	$Panel/VBoxContainer/Continue.connect("pressed", Callable(self, "_on_resume_pressed"))
	$Panel/VBoxContainer/Restart.connect("pressed", Callable(self, "_on_restart_pressed"))
	$Panel/VBoxContainer/Exit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_resume_pressed() -> void:
	game_manager.set_state(game_manager.GameState.PLAYING)

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
