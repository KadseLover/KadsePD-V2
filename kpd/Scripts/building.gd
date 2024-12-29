extends Sprite2D

var mouse_in
var dragging
var offset_
@onready var Overlay: ColorRect = $Overlay

func _ready() -> void:
	Overlay.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("LMB") and mouse_in:
		dragging = true
		offset_ = position - Global.g_tile_pos
	if !Input.is_action_pressed("LMB"):
		dragging = false

func _process(delta: float) -> void:
	if dragging:
		position = Global.g_tile_pos + offset_

func _on_mouse_entered() -> void:
	mouse_in = true
	Overlay.show()


func _on_mouse_exited() -> void:
	mouse_in = false
	Overlay.hide()
