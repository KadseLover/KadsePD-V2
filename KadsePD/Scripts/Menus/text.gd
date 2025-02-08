extends Label


var mouse_in = false
var dragging
var offset_
var spawnt
var selectet

func _ready() -> void:
	spawnt = true
	Global.connect("change_text", update)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB") and mouse_in:
		dragging = true
		offset_ = position - get_global_mouse_position()
		
	if Input.is_action_just_pressed("LMB") and !mouse_in and !Global.con_menu_mouse and !Global.in_menu:
		selectet = false
		modulate = Color.WHITE
	
	if !Input.is_action_pressed("LMB"):
		dragging = false
	
	if Input.is_action_just_pressed("RMB") and mouse_in:
		selectet = true
		modulate = Color.YELLOW

func _process(delta: float) -> void:
	if  spawnt:
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("LMB"):
			spawnt = false
	if dragging:
		position = get_global_mouse_position() + offset_
	
	

func update():
	if selectet:
		text = Global.new_text

func _on_mouse_entered() -> void:
	mouse_in = true
	Global.text_focus = true


func _on_mouse_exited() -> void:
	mouse_in = false
	Global.text_focus = false


func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB") and Global.delete_mode:
		queue_free()
