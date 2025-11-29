extends TileMapLayer

const TILE := 16
const BLOCKS := 5
#const SPEED := 60
#var offset := 0.0

var map_width := 544
var map_height := 960

var rows : int
var cols : int

var rnd := RandomNumberGenerator.new()

var blocks : Array[Vector2i] = []

var visible_blocks : int
var extra_blocks : int
var total_blocks : int

func _ready() -> void:
	rnd.randomize()
	rows = map_height / TILE
	cols = map_width / TILE
	
	visible_blocks = rows / BLOCKS
	extra_blocks = 3
	total_blocks = visible_blocks + extra_blocks
	
	#offset = -(((total_blocks * BLOCKS) - rows) * TILE)
	#position.y = 0
		
	generate_blocks()
	paint_from_blocks()
	
'func _process(delta: float) -> void:
	offset += SPEED * delta
	position.y = offset'

func generate_blocks() -> void:
	blocks.clear()
	
	var ml := rnd.randi_range(2, 5)
	var mr := rnd.randi_range(2, 5)
	
	for i in range(total_blocks):

		blocks.append(Vector2i(ml, mr))
		ml = clamp(ml + rnd.randi_range(-1, 1), 2, 5)
		mr = clamp(mr + rnd.randi_range(-1, 1), 2, 5)
		
func paint_from_blocks() -> void:
	
	clear()
	
	var index := -1
	
	for y in range(total_blocks * BLOCKS):
		if y % 5 == 0:
			index += 1
			
		var ml: int = blocks[index].x
		var mr: int = blocks[index].y
		
		for x in range(0, ml):
			set_cell(Vector2i(x, y), 0, Vector2i(1, 1))
		for x in range(cols - mr, cols):
			set_cell(Vector2i(x, y), 0, Vector2i(1, 1))
			
func shift_and_generate_new_block() -> void:

	blocks.pop_back()
	
	var ml = clamp(blocks.front().x + rnd.randi_range(-1,1), 2, 5)
	var mr = clamp(blocks.front().y + rnd.randi_range(-1,1), 2, 5)

	blocks.push_front(Vector2i(ml, mr))

	paint_from_blocks()
	
