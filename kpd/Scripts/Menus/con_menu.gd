extends PanelContainer

@onready var print: Node2D = $".."
@onready var text: Button = $GridContainer/Text
@onready var color: Button = $GridContainer/Color
@onready var change_text: Button = $"GridContainer/Change Text"
var TEXT = preload("res://Scenes/text.tscn")
@onready var text_editor: Panel = $"../CanvasLayer/Ediors/TextEditor"
@onready var color_edit: Panel = $"../CanvasLayer/Ediors/ColorEdit"

var mouse_in
var edit_text
var edit_color

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB") and !mouse_in:
		hide()

func _process(delta: float) -> void:
	pass

func _on_text_pressed() -> void:
	var new_text = TEXT.instantiate()
	new_text.position = get_global_mouse_position()
	print.add_child(new_text)
	hide()

func _on_change_text_pressed() -> void:
	text_editor.show()
	Global.in_menu = true

func _on_color_pressed() -> void:
	color_edit.show()
	Global.in_menu = true

func _on_mouse_exited() -> void:
	mouse_in = false
	Global.con_menu_mouse = false

func _on_mouse_entered() -> void:
	mouse_in = true
	Global.con_menu_mouse = true

func _on_finsh_color_pressed() -> void:
	edit_color = $"../CanvasLayer/Ediors/ColorEdit/ColorPicker".color
	print(edit_color)
	color_edit.hide()
	Global.in_menu = false

func _on_finsh_text_pressed() -> void:
	edit_text = $"../CanvasLayer/Ediors/TextEditor/Text Edit".text
	Global.new_text = edit_text
	Global.emit_signal("change_text")
	text_editor.hide()
	Global.in_menu = false

func _on_draw() -> void:
	if Global.text_focus:
		change_text.disabled = false
	else:
		change_text.disabled = true
