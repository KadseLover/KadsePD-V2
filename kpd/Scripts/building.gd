extends Sprite2D

var mouse_in
var dragging
var spawnt
var offset_
var id
var selectet
var in_selection_box
signal rotate_me
var rotate_count = 1
@onready var Overlay: ColorRect = $Overlay



func _ready() -> void:
	spawnt = true
	Overlay.hide()
	index()
	Global.connect("change_color", update_color)
	connect("rotate_me", rotate_build)

func _input(event: InputEvent) -> void:
	if Global.in_menu:
		return
	#Check ob auf dem Building Mouse Input is
	if Input.is_action_just_pressed("LMB") and mouse_in:
		dragging = true
		top_level = true
		offset_ = position - Global.g_tile_pos
	if !Input.is_action_pressed("LMB"):
		top_level = false
		dragging = false
	
	if Input.is_action_just_pressed("RMB") and mouse_in:
		selectet = true
		modulate = Color.DIM_GRAY
	
	if Input.is_action_just_pressed("LMB") and !mouse_in and !Global.con_menu_mouse and !Global.in_menu:
		selectet = false
		modulate = Color.WHITE
	
	if Input.is_action_just_pressed("Rotate") and mouse_in:
		emit_signal("rotate_me")
	



func _process(delta: float) -> void:
	if spawnt:
		if Global.id == 1:
			position = Global.g_tile_pos + Vector2(0, 17)
		else:
			position = Global.g_tile_pos
		if Input.is_action_just_pressed("LMB"):
			spawnt = false
	if dragging:
		position = Global.g_tile_pos + offset_
	
	if mouse_in and Global.delete_mode:
		Overlay.color = Color.hex(0x7000005f)
	else:
		Overlay.color = Color.hex(0x53ffff5f)
	
	if mouse_in:
		Global.build_coords = position
	
	
func _on_mouse_entered() -> void:
	mouse_in = true
	Global.building_focus = true
	Overlay.show()


func _on_mouse_exited() -> void:
	mouse_in = false
	Global.building_focus = false
	Overlay.hide()
	Global.build_coords = "(-, -)"


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Global.delete_mode and Input.is_action_just_pressed("LMB"):
		queue_free()

func index():
	match name:
		"Smelter":
			Global.id = 1
		"Foundry":
			Global.id = 2
		"Constructor":
			Global.id = 3
		"Splitter":
			Global.id = 4

func update_color():
	if selectet:
		self_modulate = Global.new_color

func _on_area_2d_area_entered(area: Area2D) -> void:
	selectet = true
	modulate = Color.DIM_GRAY

func _on_area_2d_area_exited(area: Area2D) -> void:
	if !Global.AABB_:
		selectet = true
	else:
		selectet = false
		modulate = Color.WHITE

func rotate_build():
	self.rotate(deg_to_rad(90))
