extends TileMapLayer

var map_width = 544;
var map_height = 960;
var rows: int
var cols: int

var rnd := RandomNumberGenerator.new()

func _ready() -> void:
	
	rows = map_height / 16
	cols = map_width / 16
	generate_world_blue()
	
func generate_world_blue():
	for y in range(rows, -1, -1):
		
		var margem_left = rnd.randi_range(2,5)
		var margem_right = rnd.randi_range(2,5)
		
		""" 
			desenha mapa cada celula de 16x16 no eixo X
			Vector2i(0, 0) -> agua(rio); Vector2i(0, 1) -> floresta(margem)
		"""
		"""
			for x in range(margem_left+1):
				set_cell(Vector2i(x,y),0,Vector2i(0, 1))
			for x in range(margem_left+1, (map_width/float(16))-margem_right, 1):
				set_cell(Vector2i(x,y),0,Vector2i(0, 0))
			for x in range((map_width/float(16))-margem_right,(map_width/float(16)),1):
				set_cell(Vector2i(x,y),0,Vector2i(0, 1))
		"""
		# desenho do mapa
		for x in range(cols):
			set_cell(Vector2i(x,y),0,Vector2i(0, 0) if (x >= margem_left and x < cols-margem_right) else Vector2i(0, 1))
