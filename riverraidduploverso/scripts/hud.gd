extends Control

@onready var lives_counter: Label = $BoxContainer/lives/lives_counter
@onready var fuel_counter: Label = $BoxContainer/gas/fuel_counter
@onready var score_counter: Label = $BoxContainer/score/score_counter

func _ready() -> void:
	lives_counter.text = str(Global.lives)
	fuel_counter.text = str(Global.fuel)
	score_counter.text = str(Global.score)

func _process(delta: float) -> void:
	lives_counter.text = str(Global.lives)
	fuel_counter.text = str(Global.fuel)
	score_counter.text = str(Global.score)
