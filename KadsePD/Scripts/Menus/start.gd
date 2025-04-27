extends ColorRect

@onready var name_display: Label = $"TabContainer/New save/name_display"
@onready var size_display: Label = $"TabContainer/New save/size_display"
@onready var name_: LineEdit = $"TabContainer/New save/Name"
@onready var size_: HSlider = $"TabContainer/New save/Size"
@onready var last_save: LineEdit = $TabContainer/Load_save/last_save


var can_start

var settings_path = "res://Saves/Settings.json"

func _ready() -> void:
	last_save.text = load_path(settings_path)


func _process(delta: float) -> void:
	size_display.text = "Print size: %sx%s" % [str(size_.value), str(size_.value)]
	
	if name_.text == "":
		can_start = false
		name_display.text = "Need a name!"
		name_display.modulate = Color.FIREBRICK
	else:
		can_start = true
		name_display.text = "Print name: %s" % name_.text
		name_display.modulate = Color.WHITE


func _on_start_pressed() -> void:
	if can_start:
		Global.print_size = size_.value
		Global.print_name = name_.text
		get_tree().change_scene_to_file("res://Scenes/print.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

func load_path(path):
	var file = FileAccess.open(path, FileAccess.READ)
	
	if file:
		var data = file.get_as_text()
		file.close()
		var parsed_data = JSON.parse_string(data)
		if parsed_data.has("Save-path"):
			return parsed_data["Save-path"]
		else:
			return "No last path saved"
	else:
		return ""
