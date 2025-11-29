extends CanvasLayer

@onready var game_manager := get_parent()

func _ready() -> void:
	$Panel/VBoxContainer/Play.connect("pressed", Callable(self, "_on_play_pressed"))
	$Panel/VBoxContainer/Help.connect("pressed", Callable(self, "_on_help_pressed"))
	$Panel/VBoxContainer/Exit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_play_pressed() -> void:
	game_manager.set_state(game_manager.GameState.PLAYING)

func _on_help_pressed() -> void:
	var dialog := AcceptDialog.new()
	dialog.dialog_text = "Use as setas esquerda e direita para mover.\nPressione ESC para pausar."
	add_child(dialog)
	dialog.popup_centered()

func _on_quit_pressed() -> void:
	get_tree().quit()
