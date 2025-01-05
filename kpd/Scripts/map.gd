extends TileMapLayer


var local_pos

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# "local_pos" is die locale Koordinate der tilemap von der tile auf der
	# die Maus ist; g_tile_pos is ne Globale var in der die Locale Koordinate
	# in die Global Koordinate der Tile umgewandelt wird
	local_pos = local_to_map(get_global_mouse_position())
	Global.g_tile_pos = map_to_local(local_pos) 

func fill():
	var print_height = 1000
	var print_width = 1000
	var x = Vector2i()
	var y = Vector2i()
	var z = Vector2i(999, 999)
	var c = Vector2i(999, 999)
	for i in print_height:
		set_cell(Vector2i(x), 1, Vector2i(0, 0), 0)
		x += Vector2i(1, 0)
		set_cell(Vector2i(z), 1, Vector2i(0, 0), 0)
		z -= Vector2i(1, 0)
	for i in print_width:
		set_cell(Vector2i(y), 1, Vector2i(0, 0), 0)
		y += Vector2i(0, 1)
		set_cell(Vector2i(c), 1, Vector2i(0, 0), 0)
		c -= Vector2i(0, 1)
	
