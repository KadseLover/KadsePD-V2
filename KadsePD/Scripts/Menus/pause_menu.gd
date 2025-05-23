extends Control


@onready var box: Panel = $Background/Box
@onready var tab_bar: TabBar = $Background/TabBar
@onready var input_opt: Panel = $Background/input_opt
@onready var andere_opt: Panel = $Background/andere_opt

@onready var move_sensi_slider: HSlider = $Background/input_opt/MoveSensSlider
@onready var move_sens_display: Label = $Background/input_opt/Move_sens_display

var settings
var move_sensi

var settings_save_path = "user://Settings.json"

func _ready() -> void:
	if FileAccess.file_exists(settings_save_path):
		load_data_from_file(settings_save_path)
	else:
		Global.move_sensi = 20
		move_sensi_slider.value = 20
		Global.emit_signal("change_move_sensi")
	settings = {
		"MoveSensi": 20,
	}

func _on_continue_pressed() -> void:
	hide()
	Global.in_menu = false

func _process(delta: float) -> void:
	move_sens_display.text = str(int(move_sensi_slider.value))
	
	if Input.is_action_just_pressed("Esc") and !visible:
		#if !Global.laying:
		show()
		Global.in_menu = true
	elif Input.is_action_just_pressed("Esc") and visible:
		hide()
		Global.in_menu = false

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")

func _on_options_pressed() -> void:
	box.hide()
	tab_bar.show()
	tab_bar.current_tab = 0

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
	#Change Sensi in the Camera script
	Global.move_sensi = move_sensi_slider.value
	Global.emit_signal("change_move_sensi")
	
	#Save the Settings
	updateDikt()
	save_data(settings_save_path, settings)
	
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()
	tab_bar.current_tab = -1

func _on_cancel_pressed() -> void:
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()
	tab_bar.current_tab = -1


func updateDikt():
	settings["MoveSensi"] = Global.move_sensi

func save_data(path, data):
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	file.store_line(JSON.stringify(settings))
	file.close()

func load_data_from_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	
	var data = file.get_as_text()
	file.close()
	var parsed_data = JSON.parse_string(data)
	Global.move_sensi = parsed_data["MoveSensi"]
	move_sensi_slider.value = parsed_data["MoveSensi"]
	Global.emit_signal("change_move_sensi")
