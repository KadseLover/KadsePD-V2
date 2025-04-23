extends Node


@onready var buildings: Node2D = $"../Buildings"
@onready var texts: Node2D = $"../Texts"
@onready var belts: Node2D = $"../Belts"

var building_num
var buildings_data = []
var print_data = []
var text_data = []
var belt_data = []
var all_data = []

@onready var file_save: FileDialog = $FileSave
@onready var file_load: FileDialog = $FileLoad


var building_scenes = {
	1: preload("res://Scenes/Buildings/constructor.tscn"), 
	2: preload("res://Scenes/Buildings/splitter.tscn"),
	3: preload("res://Scenes/Buildings/foundry.tscn"),
	4: preload("res://Scenes/Buildings/smelter.tscn")
}

func gather_building_data(building):
	return {
		"Typ": building.id,
		"Position": building.position,
		"Rotation": rad_to_deg(building.rotation),
		"Color": building.self_modulate.to_html()
	}


func loopBuildings():
	for building in buildings.get_children():
		var data = gather_building_data(building)
		buildings_data.append(data)



func save(path):
	all_data.append_array(buildings_data)
	
	var json_string = JSON.stringify(all_data)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		print("Building data saved successfully.")
	else:
		print("Failed to open file for writing.")


func _on_save_pressed() -> void:
	file_save.show()

func load_(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()

	var json_data = JSON.parse_string(json_string)
	var buildings_data = json_data
	# Now you can use buildings_data to recreate your buildings
	for building_info in buildings_data:
		var building_id = int(building_info["Typ"])
		if building_scenes.has(building_id):
			# Create a building instance and set its properties
			var new_building = building_scenes[building_id].instantiate()
			new_building.spawnt = false
			
			# Parse the position string to create a Vector2
			var position_string = building_info["Position"]
			var position_values = position_string.split(",")
			var position_x = float(position_values[0].lstrip("("))
			var position_y = float(position_values[1].rstrip(")"))
			new_building.position = Vector2(position_x, position_y)
			
			new_building.rotation = deg_to_rad(building_info["Rotation"])
			new_building.self_modulate = Color(building_info["Color"])
			add_child(new_building)
		else:
			print("No scene found for building type: ", building_id)


func _on_load_pressed() -> void:
	file_load.show()


func _on_file_save_file_selected(path: String) -> void:
	loopBuildings()
	save(path)

func _on_file_load_file_selected(path: String) -> void:
	load_(path)
