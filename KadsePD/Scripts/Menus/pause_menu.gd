extends Control

func _process(delta: float) -> void:
	if visible:
		Global.in_menu = true
	else:
		Global.in_menu = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Cancel") and visible:
		hide()

func _on_continue_pressed() -> void:
	hide()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")
