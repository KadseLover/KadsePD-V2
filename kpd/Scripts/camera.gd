extends Camera2D

var mouse_start_pos
var screen_start_position
var dragging = false
var Cam_y
var Cam_x
var zoom_scale = 1
var Speed = 100
var _zoom = 1
var zoom_str = 0.1

func _ready() -> void:
	#Kamera Zentrieren
	Cam_y = position.y
	Cam_x = position.x

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
	
	if Input.is_action_just_pressed("Cam_reset"):
		Cam_x = 5500
		Cam_y = 3500
		self.set_position(Vector2(Cam_x, Cam_y))
	
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
