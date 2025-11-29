extends CanvasLayer

func set_lives(value: int) -> void:
	$MarginContainer/VBoxContainer/Lives.text = "Vidas: %d" % value

func set_score(value: int) -> void:
	$MarginContainer/VBoxContainer/Score.text = "Pontos: %d" % value
	
func set_fuel(value: int) -> void:
	$MarginContainer/VBoxContainer/Fuel.text = "GAS: %d" % value
