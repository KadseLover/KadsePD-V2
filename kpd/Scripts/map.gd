extends TileMapLayer

var local_pos

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	local_pos = local_to_map(get_global_mouse_position())
	Global.g_tile_pos = map_to_local(local_pos)
	
