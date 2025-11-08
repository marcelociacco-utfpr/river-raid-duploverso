extends TileMapLayer

var map_width = 544;
var map_height = 960;
var rows: int
var cols: int

const TILE := 16
const SPEED := 120.0
var accum := 0.0

var rnd := RandomNumberGenerator.new()

var rows_data: Array[Vector2i] = []

func _ready() -> void:
	rnd.randomize()
	rows = map_height / TILE
	cols = map_width / TILE
	generate_world_blue()
	
func _process(delta: float) -> void:
	accum += SPEED * delta
	position.y += SPEED * delta

	if accum >= TILE:
		accum -= TILE
		position.y -= TILE 

func generate_world_blue():
	
	var margem_left := rnd.randi_range(2, 5)
	var margem_right := rnd.randi_range(2, 5)
	
	for y in range(rows-1, -1, -1):	
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
		"""
		for x in range(0,margem_left):
			set_cell(Vector2i(x,y), 0, Vector2i(0, 1))
		for x in range(cols-margem_right,cols):
			set_cell(Vector2i(x,y), 0, Vector2i(0, 1))
		"""
		
		paint_row(y, margem_left,margem_right)
		# fiz o range de -1 e 1, mas estava estourando
		# chatGPT me deu solução com CLAMP, consegue limitar entre 2 e 5
		margem_left = clamp(margem_left + rnd.randi_range(-1, 1), 2, 5)
		margem_right = clamp(margem_right + rnd.randi_range(-1, 1), 2, 5)
		
	rows_data.clear()
	var ml := margem_left
	var mr := margem_right
	for y in range(rows-1, -1, -1):
		rows_data.append(Vector2i(ml, mr))
		paint_row(y, ml, mr)
		ml = clamp(ml + rnd.randi_range(-1, 1), 2, 5)
		mr = clamp(mr + rnd.randi_range(-1, 1), 2, 5)
		
func paint_row(y: int, margem_left: int, margem_right: int) -> void:
	for x in range(0, margem_left):
		set_cell(Vector2i(x, y), 0, Vector2i(0, 1))
	for x in range(cols - margem_right, cols):
		set_cell(Vector2i(x, y), 0, Vector2i(0, 1))
