extends Panel

@onready var file_dialog: FileDialog = $load/FileDialog

const text_scene = preload("res://Scenes/text.tscn")


var building_scenes = {
	1: preload("res://Scenes/Buildings/constructor.tscn"), 
	2: preload("res://Scenes/Buildings/splitter.tscn"),
	3: preload("res://Scenes/Buildings/foundry.tscn"),
	4: preload("res://Scenes/Buildings/smelter.tscn")
}

var belt_scenes = {
	1: preload("res://Scenes/belt.tscn"),
	2: preload("res://Scenes/pipe.tscn")
}


func load_(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var json_string = file.get_as_text(true)
	file.close()
	
	var json_data = JSON.parse_string(json_string)
	
	# If a Sub-Dict in json_data has "Building" in it, it gets assignt to buildings_data
	for key in json_data["Building"].keys():
		if "Building" in key:
			assign_build_data(json_data["Building"][key])
	
	# If a Sub-Dict in json_data has "Text" in it, it gets assignt to texts_data
	for key in json_data["Text"].keys():
		if "Text" in key:
			assign_text_data(json_data["Text"][key])
	
	# If a Sub-Dict in json_data has "Belt" in it, it gets assignt to belts_data
	for key in json_data["Belt"].keys():
		if "Belt" in key:
			assign_belt_data(json_data["Belt"][key])
	
	for key in json_data["Print"].keys():
		if "Print" in key:
			if json_data["Print"][key] is String:
				Global.print_name = json_data["Print"][key]
			else:
				Global.print_size = json_data["Print"][key]


func assign_build_data(buildings_data):
	# Loading the data for the Buildings in buildings_data
	var building_id = int(buildings_data["Building-typ"])
	if building_scenes.has(building_id):
		# Spawn the right type of Building according to the building_id
		var new_building = building_scenes[building_id].instantiate()
		new_building.spawnt = false
		# Split "(x, y)" by the comma and strip the brakets to get the floats
		var position_string = buildings_data["Building-pos"]
		var position_values = position_string.split(",")
		var position_x = float(position_values[0].lstrip("("))
		var position_y = float(position_values[1].rstrip(")"))
		new_building.position = Vector2(position_x, position_y)
		# Assign the Rotation, Color and spawn the building
		new_building.rotation = deg_to_rad(buildings_data["Building-rot"])
		new_building.self_modulate = Color(buildings_data["Building-color"])
		Global.loaded_building_arr.append(new_building)

func assign_text_data(texts_data):
	var new_text = text_scene.instantiate()
	new_text.spawnt = false
	# Split "(x, y)" by the comma and strip the brakets to get the floats
	var position_string = texts_data["Text-pos"]
	var position_values = position_string.split(",")
	var position_x = float(position_values[0].lstrip("("))
	var position_y = float(position_values[1].rstrip(")"))
	new_text.position = Vector2(position_x, position_y)
	# Assign the text and spawn the text
	new_text.text = texts_data["Text-text"]
	Global.loaded_text_arr.append(new_text)
	
func assign_belt_data(belts_data):
	var belt_id = int(belts_data["Belt-typ"])
	if belt_scenes.has(belt_id):
		# Spawn the right type of Belt according to the belt_id
		var new_belt = belt_scenes[belt_id].instantiate()
		new_belt.spawnt = false
		new_belt.loaded_in = true
		
		# Split "(x, y)" by the comma and strip the brakets to get the floats
		var pos_string = belts_data["Belt-pos"]
		var pos_values = pos_string.split(",")
		var pos_x = float(pos_values[0].lstrip("("))
		var pos_y = float(pos_values[1].rstrip(")"))
		new_belt.position = Vector2(pos_x, pos_y)
		
		for point_pos in belts_data["Belt-point_pos"]:
			var position_values = point_pos.split(",")
			var position_x = float(position_values[0].lstrip("("))
			var position_y = float(position_values[1].rstrip(")"))
			new_belt.add_point(Vector2(position_x, position_y))
		
		Global.loaded_belt_arr.append(new_belt)


func _on_load_pressed() -> void:
	file_dialog.show()


func _on_file_dialog_file_selected(path: String) -> void:
	get_tree().change_scene_to_file("res://Scenes/print.tscn") 
	load_(path)
