extends Control

@onready var box: Panel = $Background/Box
@onready var tab_bar: TabBar = $Background/TabBar
@onready var input_opt: Panel = $Background/input_opt
@onready var andere_opt: Panel = $Background/andere_opt

func _on_continue_pressed() -> void:
	hide()
	Global.in_menu = false


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
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()


func _on_cancel_pressed() -> void:
	tab_bar.hide()
	input_opt.hide()
	andere_opt.hide()
	box.show()
