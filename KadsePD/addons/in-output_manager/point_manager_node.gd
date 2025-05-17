@tool
extends Node2D

const INPUT = preload("res://Scenes/input.tscn")
const OUTPUT = preload("res://Scenes/output.tscn")

@export var Inputs : PackedVector3Array:
	set(value):
		Inputs = value
		update_inputs()
		queue_redraw()

@export var Outputs : PackedVector3Array:
	set(value):
		Outputs = value
		update_outputs()
		queue_redraw()

@export_group("Point  Settings")
@export_range(0.1, 5.0, 0.1) var Scale := 1.0:
	set(value):
		Scale = value
		update_inputs()
		update_outputs()

@export_group("Crosshair Settings", "crosshair_")
@export_range(200.0, 2000.0, 1.0) var crosshair_size := 200.0:
	set(value):
		crosshair_size = value
		queue_redraw()

@export_range(2.0, 5.0, 0.1) var crosshair_thickness := 2.0:
	set(value):
		crosshair_thickness = value
		queue_redraw()

func update_inputs():
	var children = get_children()
	for child in children:
		if child.is_in_group("Inputs"):
			child.queue_free()
	
	for input in Inputs:
		var new_input = INPUT.instantiate()
		new_input.add_to_group("Inputs")
		new_input.scale = Vector2(Scale, Scale)
		new_input.position.x = input.x
		new_input.position.y = input.y
		new_input.rotation = deg_to_rad(input.z)
		new_input.z_index = -1
		add_child(new_input)

func update_outputs():
	var children = get_children()
	for child in children:
		if child.is_in_group("Outputs"):
			child.queue_free()
	
	for output in Outputs:
		var new_input = OUTPUT.instantiate()
		new_input.add_to_group("Outputs")
		new_input.scale = Vector2(Scale, Scale)
		new_input.position.x = output.x
		new_input.position.y = output.y
		new_input.rotate(deg_to_rad(output.z))
		new_input.z_index = -1
		add_child(new_input)

func _draw():
	if Engine.is_editor_hint():
		var half_size = crosshair_size / 2
		
		for input in Inputs:
			draw_line(
				Vector2(input.x, input.y) + Vector2(-half_size, 0),
				Vector2(input.x, input.y) + Vector2(half_size, 0),
				Color.FIREBRICK,
				crosshair_thickness
			)

			draw_line(
				Vector2(input.x, input.y) + Vector2(0, -half_size),
				Vector2(input.x, input.y) + Vector2(0, half_size),
				Color.YELLOW,
				crosshair_thickness
			)
		
		for output in Outputs:
			draw_line(
				Vector2(output.x, output.y) + Vector2(-half_size, 0),
				Vector2(output.x, output.y) + Vector2(half_size, 0),
				Color.FIREBRICK,
				crosshair_thickness
			)

			draw_line(
				Vector2(output.x, output.y) + Vector2(0, -half_size),
				Vector2(output.x, output.y) + Vector2(0, half_size),
				Color.YELLOW,
				crosshair_thickness
			)

func _process(delta: float) -> void:
	if Global.laying or Global.building:
		visible = true
	else:
		visible = false

func _ready() -> void:
	z_index = 1
