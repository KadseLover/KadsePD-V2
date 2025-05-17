extends Panel

var dragging = false
var start
var end
var leftdown
var leftup
var rightup
var rightdown
var shape_size = 20

@onready var area: Area2D = $"../Area2D"
@onready var shape: CollisionShape2D = $"../Area2D/CollisionShape2D"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _ready() -> void:
	shape.disabled = true
	position = Vector2.ZERO
	size = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("LMB"):
		Global.AABB_ = false
		animation_player.play("Fade_out")
		dragging = false
	
	if Global.building_focus or Global.in_menu or Global.con_menu_mouse or Global.text_focus:
		return
	
	if Input.is_action_just_pressed("LMB"):
		start = get_global_mouse_position()
		position = start
		dragging = true
		shape.disabled = false
		animation_player.play("Fade_in")
		
func _process(delta: float) -> void:
	Global.selection_visible = visible
	if dragging:
		Global.AABB_ = true
		end = get_local_mouse_position()
		if get_global_mouse_position().x < start.x:
			#Left down
			scale.x = -1
			end.x = -end.x
		elif get_global_mouse_position().x > start.x:
			#Right up
			scale.x = 1
		if get_global_mouse_position().y < start.y:
			#Left up
			scale.y = -1
			end.y = -end.y
		elif get_global_mouse_position().y > start.y:
			#Right down
			scale.y = 1
		size = (get_global_mouse_position() - start) * scale
		shape.scale = size / shape_size
		shape.position = calc_middle(start.x, end.x, start.y, end.y)

func calc_middle(a_x, b_x, a_y, b_y):
	var M : Vector2
	var M_x : float
	var M_y : float
	M_x = a_x + b_x / 2
	M_y = a_y + b_y / 2
	M = Vector2(M_x, M_y)
	return M


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade_out":
		position = Vector2.ZERO
		size = Vector2.ZERO
		shape.disabled = true
