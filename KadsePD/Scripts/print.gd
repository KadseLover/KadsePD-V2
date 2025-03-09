extends Node2D

@onready var fps: Label = $CanvasLayer/Labels/fps
@onready var name_: Label = $CanvasLayer/Labels/name
@onready var Con_menu: PanelContainer = $Con_menu
@onready var coords: Label = $CanvasLayer/Labels/Coords
@onready var labels: Control = $CanvasLayer/Labels
@onready var pause_menu: Control = $CanvasLayer/Pause_menu
@onready var del_ramen: ColorRect = $CanvasLayer/del_ramen
@onready var camera: Camera2D = $Camera2D
@onready var animation_delete: AnimationPlayer = $CanvasLayer/del_ramen/Animation_delete
var PIPE = preload("res://Scenes/pipe.tscn")
var CONSTRUCTOR = preload("res://Scenes/Buildings/constructor.tscn")
var FOUNDRY = preload("res://Scenes/Buildings/foundry.tscn")
var SMELTER = preload("res://Scenes/Buildings/smelter.tscn")
var SPLITTER = preload("res://Scenes/Buildings/splitter.tscn")
var BELT = preload("res://Scenes/belt.tscn")
var TEXT = preload("res://Scenes/text.tscn")

func _ready() -> void:
	get_tree().root.size_changed.connect(resize) 
	resize()
	Global.connect("light_cancel_belt", belt_cancel)
	Global.connect("light_cancel_pipe", pipe_cancel)
	name_.text = "Name: " + str(Global.print_name)

func resize():
	var screen_size = DisplayServer.window_get_size()
	del_ramen.size = screen_size

func _process(delta: float) -> void:
	fps.set_text("FPS: %d" % Engine.get_frames_per_second())
	coords.text = "Coords: " + str(Global.build_coords)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("show fps"):
		labels.show()
	if Input.is_action_just_pressed("hide_fps"):
		labels.hide()
	
	if Input.is_action_just_pressed("Cancel"):
		pause_menu.show()
		Global.in_menu = true
	
	if Global.in_menu:
		return
	
	if Input.is_action_just_pressed("Belts"):
		spawn_belt()
	
	if Input.is_action_just_pressed("Delete"):
		Global.delete_mode = true
		del_ramen.show()
		animation_delete.play("fade_in")
		animation_delete.play("Color_change")
	if Input.is_action_just_released("Delete"):
		Global.delete_mode = false
		#del_ramen.hide()
		animation_delete.stop()
		animation_delete.play("fade_out")
	
	if Input.is_action_just_pressed("RMB"):
		Con_menu.hide()
		Con_menu.show()
		Con_menu.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("Belts"):
		spawn_belt()
	
	if Input.is_action_just_pressed("Pipe"):
		spawn_pipe()

	if Input.is_action_just_pressed("Constructor"):
		spawn_constructor()
	
	if Input.is_action_just_pressed("Foundry"):
		spawn_foundry()
	
	if Input.is_action_just_pressed("Smelter"):
		spawn_smelter()
	
	if Input.is_action_just_pressed("Splitter"):
		spawn_splitter()

func spawn_text():
	var new_text = TEXT.instantiate()
	new_text.position = get_global_mouse_position()
	add_child(new_text)

func belt_cancel():
	Global.building = true
	Global.laying = true
	var new_Belt = BELT.instantiate()
	add_child(new_Belt)

func pipe_cancel():
	Global.building = true
	Global.laying = true
	var new_Pipe = PIPE.instantiate()
	add_child(new_Pipe)

func spawn_belt():
	var new_belt = BELT.instantiate()
	new_belt.position = get_global_mouse_position()
	add_child(new_belt)

func spawn_pipe():
	var new_pipe = PIPE.instantiate()
	new_pipe.position = get_global_mouse_position()
	add_child(new_pipe)

func spawn_constructor():
	var new_Constructor = CONSTRUCTOR.instantiate()
	new_Constructor.position = get_global_mouse_position()
	add_child(new_Constructor)

func spawn_foundry():
	var new_foundry = FOUNDRY.instantiate()
	new_foundry.position = get_global_mouse_position()
	add_child(new_foundry)

func spawn_smelter():
	var new_smelter = SMELTER.instantiate()
	new_smelter.position = get_global_mouse_position()
	add_child(new_smelter)

func spawn_splitter():
	var new_splitter = SPLITTER.instantiate()
	new_splitter.position = get_global_mouse_position()
	add_child(new_splitter)

#Buttons

func _on_constructor_pressed() -> void:
	spawn_constructor()

func _on_smelter_pressed() -> void:
	spawn_smelter()

func _on_foundry_pressed() -> void:
	spawn_foundry()

func _on_splitter_pressed() -> void:
	spawn_splitter()

func _on_belt_pressed() -> void:
	spawn_belt()

func _on_pipe_pressed() -> void:
	spawn_pipe()

func _on_text_pressed() -> void:
	spawn_text()
