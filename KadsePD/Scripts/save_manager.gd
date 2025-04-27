extends Node


@onready var buildings: Node2D = $"../Buildings"
@onready var texts: Node2D = $"../Texts"
@onready var belts: Node2D = $"../Belts"

var all_data = {}
var buildings_data = {}
var texts_data = {}
var belts_data = {}

@onready var file_save: FileDialog = $FileSave

var settings_path = "res://Saves/Settings.json"

func gather_building_data(building):
	return {
		"Building-typ": building.id,
		"Building-pos": building.position,
		"Building-rot": rad_to_deg(building.rotation),
		"Building-color": building.self_modulate.to_html()
	}

func loopBuildings():
	var i = 1
	for building in buildings.get_children():
		var data = gather_building_data(building)
		buildings_data["Building" + str(i)] = data
		i += 1

func gather_text_data(text):
	return {
		"Text-pos": text.position,
		"Text-text": text.text
	}

func loopTexts():
	var i = 1
	for text in texts.get_children():
		var data = gather_text_data(text)
		texts_data["Text" + str(i)] = data
		i += 1

func gather_belt_data(belt):
	var point_arr = []
	for point_index in belt.get_point_count() - 1:
		point_arr.append(belt.get_point_position(point_index))
	return {
		"Belt-typ": belt.id,
		"Belt-pos": belt.position,
		"Belt-point_pos": point_arr
	}

func loopBelts():
	var i = 1
	for belt in belts.get_children():
		var data = gather_belt_data(belt)
		belts_data["Belt" + str(i)] = data
		i += 1

func gather_print_data():
	return {
		"Print-name": Global.print_name,
		"Print-size": Global.print_size
	}

func save(path):
	all_data["Building"] = buildings_data
	all_data["Text"] = texts_data
	all_data["Belt"] = belts_data
	all_data["Print"] = gather_print_data()
	
	buildings_data = {}
	texts_data = {}
	belts_data = {}
	
	print_rich("[color=green] %s [/color]" % all_data)
	
	var json_string = JSON.stringify(all_data)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()

func _on_save_pressed() -> void:
	file_save.show()

func _on_file_save_file_selected(path: String) -> void:
	loopBuildings()
	loopTexts()
	loopBelts()
	save(path)
	save_path_settings(settings_path, path)


func save_path_settings(path, data):
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	
	var old_data = file.get_as_text()
	var parsed_old_data = JSON.parse_string(old_data)
	
	parsed_old_data["Save-path"] = data
	
	file.store_line(JSON.stringify(parsed_old_data))
	file.close()
