extends TileMapLayer

var map_width = 544;
var map_height = 960;
var rows: int
var cols: int

var rnd := RandomNumberGenerator.new()

func _ready() -> void:
	
	rows = map_height / 16
	cols = map_width / 16
	generate_world_purple()
	
func generate_world_purple():
	for y in range(rows, -1, -1):
		
		var margem_left = rnd.randi_range(2,5)
		var margem_right = rnd.randi_range(2,5)
		
		# desenho do mapa
		for x in range(cols):
			set_cell(Vector2i(x,y),0,Vector2i(1, 0) if (x >= margem_left+1 and x < cols-margem_right) else Vector2i(1, 1))
