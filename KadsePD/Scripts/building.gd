extends Sprite2D

var mouse_in
var dragging
var spawnt
var offset_
var id
var selectet = false
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

	if Input.is_action_just_pressed("LMB") and mouse_in:
		dragging = true
		Global.one_build_dragged = true
		top_level = true
		
	if !Input.is_action_pressed("LMB"):
		top_level = false
		dragging = false
		Global.one_build_dragged = false
	
	if Input.is_action_just_pressed("RMB") and mouse_in:
		selectet = true
		modulate = Color.DIM_GRAY
	
	if Input.is_action_just_pressed("LMB") and !Global.building_focus and !Global.con_menu_mouse and !Global.in_menu:
		selectet = false
		modulate = Color.WHITE
		Global.selectet_arr.erase(self)
	
	if Input.is_action_just_pressed("Rotate") and mouse_in:
		emit_signal("rotate_me")
	
	if Input.is_action_just_pressed("del_group"):
		if selectet:
			queue_free()



func _process(delta: float) -> void:
	move_build()
	offset_ = position - Global.g_tile_pos
	if spawnt:
		if Global.id == 1:
			position = Global.g_tile_pos + Vector2(0, 17)
		else:
			position = Global.g_tile_pos
		if Input.is_action_just_pressed("LMB"):
			spawnt = false
		
	if mouse_in and Global.delete_mode:
		Overlay.color = Color.hex(0x7000005f)
	else:
		Overlay.color = Color.hex(0x53ffff5f)
	
	if mouse_in:
		Global.build_coords = position

func move_build():
	if Global.one_build_dragged and Global.selectet_arr.has(self):
		self.position = Global.g_tile_pos + offset_
	if dragging:
		position = Global.g_tile_pos + offset_

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
		Global.building_focus = false
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
	append_select_list()
	selectet = true
	modulate = Color.DIM_GRAY

func _on_area_2d_area_exited(area: Area2D) -> void:
	erase_select_list()
	if !Global.AABB_:
		selectet = true
	else:
		selectet = false
		modulate = Color.WHITE

func rotate_build():
	self.rotate(deg_to_rad(90))

func append_select_list():
	if !Global.selectet_arr.has(self):
		Global.selectet_arr.append(self)

func erase_select_list():
	if Input.is_action_pressed("LMB"):
		Global.selectet_arr.erase(self)
