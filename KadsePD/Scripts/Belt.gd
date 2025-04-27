extends Line2D

var pressed_spawn
var point
var spawnt = true
var loaded_in = false
var delet_mode
var cancelt
var last_point
var can_revert
var mouse_in
@onready var static_body: StaticBody2D = $StaticBody2D
@onready var panel: Panel = $Panel
@export var id: int

func _ready() -> void:
	Global.can_get_back = true
	Global.can_drag = false
	Global.laying = true
	panel.show()
	cancelt = false
	can_revert = true

func _input(event: InputEvent) -> void:
	# Add Colision Shapes to belt:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			panel.hide()
			spawnt = false
			add_point(Global.g_tile_pos)
			if points.size() != 2:
				for i in points.size() - points.size() + 1:
					var new_shape = CollisionShape2D.new()
					new_shape.debug_color = Color.CHARTREUSE
					new_shape.modulate.a = 0.5
					static_body.add_child(new_shape)
					var rect = RectangleShape2D.new()
					new_shape.position = (points[point] + points[last_point]) / 2
					new_shape.rotation = points[point].direction_to(points[last_point]).angle()
					var length = points[point].distance_to(points[last_point])
					rect.extents = Vector2(length / 2, width / 2)
					new_shape.shape = rect
	
	if id == 1:
		if Input.is_action_just_pressed("Belts"):
			can_revert = false
			cancelt = true
			Global.light_cancel_belt.emit()
	if id == 2:
		if Input.is_action_just_pressed("Pipe"):
			can_revert = false
			cancelt = true
			Global.light_cancel_pipe.emit()
	
	if Input.is_action_just_pressed("Cancel"):
		Global.can_get_back = false
		can_revert = false
		Global.can_drag = true
		cancelt = true
		Global.building = false
		Global.laying = false
		panel.hide()
	
	if Input.is_action_just_pressed("revert") and can_revert:
		remove_point(point)
		static_body.get_children().back().queue_free()


func _process(delta: float) -> void:
	point = get_point_count() - 1
	last_point = point - 1
	if spawnt:
		position = Global.g_tile_pos
	elif !loaded_in:
		if !cancelt:
			set_point_position(point, to_local(Global.g_tile_pos))
		else:
			set_point_position(point, get_point_position(last_point))




func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Global.delete_mode and Input.is_action_just_pressed("LMB"):
		queue_free()


func _on_static_body_2d_mouse_entered() -> void:
	mouse_in = true


func _on_static_body_2d_mouse_exited() -> void:
	mouse_in = false
