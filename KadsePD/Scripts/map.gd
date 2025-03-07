extends TileMapLayer

@onready var found_div: TextureRect = $found_div

var tile_size = 34
var local_pos
var pos = Vector2i()

func _ready() -> void:
	fill()
	found_div.show()
	found_div.position = get_used_rect().position
	found_div.size = get_used_rect().size * tile_size

func _process(delta: float) -> void:
	# "local_pos" is die locale Koordinate der tilemap von der tile auf der
	# die Maus ist; g_tile_pos is ne Globale var in der die Locale Koordinate
	# in die Global Koordinate der Tile umgewandelt wird
	local_pos = local_to_map(get_global_mouse_position())
	Global.g_tile_pos = map_to_local(local_pos) 

func fill():
	for i in Global.print_size:
		set_tiles()
		check()

func check():
	pos.x -= Global.print_size
	pos.y += 1

func set_tiles():
	for i in Global.print_size:
		set_cell(pos, 1, Vector2(0,0),0)
		pos.x += 1
