extends TileMapLayer

const TILE := 16
const BLOCKS := 5

var map_width := 544
var map_height := 960

var rows : int
var cols : int

var rnd := RandomNumberGenerator.new()

var blocks : Array[Vector2i] = []

func _ready() -> void:
	rnd.randomize()
	rows = map_height / TILE
	cols = map_width / TILE
	
	generate_blocks()
	paint_from_blocks()

func generate_blocks() -> void:
	blocks.clear()
	
	var visible_blocks := rows / BLOCKS
	var extra_blocks := 3
	var total_blocks := visible_blocks + extra_blocks
	
	var ml := rnd.randi_range(2, 5)
	var mr := rnd.randi_range(2, 5)
	
	for i in range(total_blocks):
		blocks.append(Vector2i(ml, mr))
		ml = clamp(ml + rnd.randi_range(-1, 1), 2, 5)
		mr = clamp(ml + rnd.randi_range(-1, 1), 2, 5)
		
func paint_from_blocks() -> void:
	
	clear()
	
	for index in range(blocks.size()):
		
		var ml := blocks[index].x
		var mr := blocks[index].y
		
		for i in range(BLOCKS):
			var y := index * BLOCKS + i
			
			if y >= rows:
				return
								  
			for x in range(0, ml):
				set_cell(Vector2i(x, y), 0, Vector2i(0, 1))
			for x in range(cols - mr, cols):
				set_cell(Vector2i(x, y), 0, Vector2i(0, 1))
