extends Node2D

@onready var fps: Label = $CanvasLayer/fps
@onready var del_ramen: TextureRect = $CanvasLayer/del_ramen
var PIPE = preload("res://Scenes/pipe.tscn")
var CONSTRUCTOR = preload("res://Scenes/constructor.tscn")
var FOUNDRY = preload("res://Scenes/foundry.tscn")
var SMELTER = preload("res://Scenes/smelter.tscn")
var SPLITTER = preload("res://Scenes/splitter.tscn")
var BELT = preload("res://Scenes/belt.tscn")

func _ready() -> void:
	Global.connect("light_cancel_belt", belt_cancel)
	Global.connect("light_cancel_pipe", pipe_cancel)
	fps.hide()

func _process(delta: float) -> void:
	fps.set_text("FPS: %d" % Engine.get_frames_per_second())

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("show fps"):
		fps.show()
	if Input.is_action_just_pressed("hide_fps"):
		fps.hide()
	
	if Input.is_action_just_pressed("Belts"):
		spawn_belt()
	
	if Input.is_action_just_pressed("Delete"):
		Global.delete_mode = true
		del_ramen.show()
	if Input.is_action_just_released("Delete"):
		Global.delete_mode = false
		del_ramen.hide()
	
	if Input.is_action_just_pressed("Belts"):
		spawn_belt()
	
	if Input.is_action_just_pressed("Pipe"):
		spawn_pipe()

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
