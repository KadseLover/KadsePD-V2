extends TileMapLayer

var local_pos

func _process(delta: float) -> void:
	# "local_pos" is die locale Koordinate der tilemap von der tile auf der
	# die Maus ist; g_tile_pos is ne Globale var in der die Locale Koordinate
	# in die Global Koordinate der Tile umgewandelt wird
	local_pos = local_to_map(get_global_mouse_position())
	Global.g_tile_pos = map_to_local(local_pos)
	
