extends Panel

@onready var label: Label = $Ramen/Label
@onready var tab_container: TabContainer = $Ramen/TabContainer
@onready var name_: LineEdit = $Ramen/TabContainer/Name
@onready var size_: HSlider = $Ramen/TabContainer/Size
@onready var ramen: Panel = $Ramen

func _ready() -> void:
	Global.print_size = size_.value
	Global.print_name = label.text
	

func _process(delta: float) -> void:
	if size_.visible:
		Global.print_size = size_.value
		label.text = "Size: " + str(Global.print_size) + "x" + str(Global.print_size)
	
	if name_.visible:
		Global.print_name = name_.text
		if name_.text == "":
			label.text = "Need Name!"
			label.modulate = Color.CRIMSON
		else:
			label.text = "Name: " + str(Global.print_name)
			label.modulate = Color.WHITE

func _on_start_pressed() -> void:
	ramen.hide()
	get_tree().change_scene_to_file("res://Scenes/print.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
