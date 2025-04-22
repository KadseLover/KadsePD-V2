extends Control

var settings
var settings_path = "res://Saves/Settings.json"

@onready var box: Panel = $Background/Box
@onready var tab_bar: TabBar = $Background/TabBar
@onready var input_opt: Panel = $Background/input_opt
@onready var andere_opt: Panel = $Background/andere_opt

@onready var move_sensi_slider: HSlider = $Background/input_opt/MoveSensSlider
@onready var move_sens_display: Label = $Background/input_opt/Move_sens_display

func _ready() -> void:
	apply_changes()

func _on_continue_pressed() -> void:
	hide()
	Global.in_menu = false

func _process(delta: float) -> void:
	move_sens_display.text = str(int(move_sensi_slider.value))

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")


func _on_options_pressed() -> void:
	box.hide()
	tab_bar.show()

func options(tab):
	if tab == 0:
		input_opt.show()
		andere_opt.hide()
	
	if tab == 1:
		andere_opt.show()
		input_opt.hide()

func _on_tab_bar_tab_changed(tab: int) -> void:
	options(tab)


func _on_finish_pressed() -> void:
	save_Settings(settings_path, manageSettings())
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()
	
	Global.move_sensi = move_sensi_slider.value
	Global.emit_signal("change_sensi")


func _on_cancel_pressed() -> void:
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()


func manageSettings():
	print("Manage")
	settings = {
		"Move_sensi": Global.move_sensi
	}
	return settings
	
func save_Settings(path, data):
	print("pre-File")
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		print("File")
		file.store_line(JSON.stringify(data))
		file.close()

func load_Settings(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var data = file.get_as_text()
		file.close()
		return JSON.parse_string(data)
	else:
		return ""

func apply_changes():
	Global.move_sensi = load_Settings(settings_path)
	Global.emit_signal("change_sensi")
