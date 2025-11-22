extends Node2D

var score: int = 0
var fuel: int = 0

func add_score(amount: int) -> void:
	score += amount
	print("PONTOS:", score)
	
func add_fuel(amount: int) -> void:
	fuel += amount
	print("FUEL:", fuel)
