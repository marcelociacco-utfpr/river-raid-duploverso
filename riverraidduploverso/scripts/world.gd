extends Node2D

class_name World

const SPEED := 200      
var offset := -240.0
var scroll := 0.0

@onready var river := $River

func _ready():
	river.position.y = offset

func _process(delta):
	offset += SPEED * delta
	scroll += SPEED * delta
	
	if scroll >= 80:
		scroll -= 80
		offset -= 80
		river.shift_and_generate_new_block()
		get_tree().current_scene.remove_fuel(10)
	river.position.y = offset
