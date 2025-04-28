extends Camera2D

var mouse_start_pos
var screen_start_position
var dragging = false
var Cam_y
var Cam_x
var zoom_scale = 1
var Speed = 20
var _zoom = 1
var zoom_str = 0.1


func _ready() -> void:
	Global.connect("change_move_sensi", changeMoveSensi)

func changeMoveSensi():
	position = Vector2(Global.cam_start_pos.x, Global.cam_start_pos.y)
	Speed = Global.move_sensi

func _input(event: InputEvent) -> void:
	#Mouse Movement
	if event.is_action("MMB"):
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = zoom_scale * (mouse_start_pos - event.position) + screen_start_position
		Cam_y = position.y
		Cam_x = position.x

func _process(delta: float) -> void:
	#Movement
	if Input.is_action_pressed("Cam_down"):
		Cam_y += Speed
		self.set_position(Vector2(Cam_x, Cam_y))
	
	if Input.is_action_pressed("Cam_up"):
		Cam_y -= Speed
		self.set_position(Vector2(Cam_x, Cam_y))
	
	if Input.is_action_pressed("Cam_right"):
		Cam_x += Speed
		self.set_position(Vector2(Cam_x, Cam_y))
	
	if Input.is_action_pressed("Cam_left"):
		Cam_x -= Speed
		self.set_position(Vector2(Cam_x, Cam_y))
	
	if Input.is_action_just_pressed("Cam_reset") and !Global.in_menu:
		center_cam_()
		#self.set_position(Cam)
	
	#Zoom
	if Input.is_action_just_pressed("zoom_in"):
		if _zoom <= 1.5:
			_zoom += zoom_str
			if zoom_scale >= 0.3:
				zoom_scale -= zoom_str
			self.set_zoom(Vector2(_zoom, _zoom))
		
	if Input.is_action_just_pressed("zoom_out"):
		if _zoom > 0.4:
			_zoom -= zoom_str
			zoom_scale += zoom_str
			self.set_zoom(Vector2(_zoom, _zoom))

func center_cam_():
	#Kamera Zentrieren
	Cam_y = Global.cam_start_pos.y
	Cam_x = Global.cam_start_pos.x
	var Cam = Vector2(Cam_x, Cam_y)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Cam, 0.2)
