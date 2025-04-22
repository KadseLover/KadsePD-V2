extends PanelContainer

@onready var main: GridContainer = $Main
@onready var production: GridContainer = $Production
@onready var logistic: GridContainer = $Logistic
@onready var menu: Button = $"../Menu"
@onready var menu_name: Label = $"../LabelDings/Menu Name"
@onready var label_dings: PanelContainer = $"../LabelDings"
@onready var color: GridContainer = $Color

func _ready() -> void:
	resize()
	get_tree().root.size_changed.connect(resize) 

func _on_production_pressed() -> void:
	production.show()
	main.hide()
	menu_name.set_text("Production Menu")


func _on_logistic_pressed() -> void:
	logistic.show()
	main.hide()
	menu_name.set_text("Logistics Menu")

func _on_back_pressed() -> void:
	main.show()
	production.hide()
	menu_name.set_text("Main Menu")

func _on_back_log_pressed() -> void:
	main.show()
	logistic.hide()
	menu_name.set_text("Main Menu")

func _on_menu_pressed() -> void:
	show()
	label_dings.show()
	menu.hide()
	menu_name.set_text("Main Menu")

func _on_back_men_pressed() -> void:
	hide()
	label_dings.hide()
	menu.show()

func resize():
	var screen_size = DisplayServer.window_get_size()
	#print(screen_size.x, " | ", screen_size.y)
	menu.position = Vector2i(screen_size.x - screen_size.x, menu.size.y / screen_size.y)


func _on_back_col_pressed() -> void:
	color.hide()
	main.show()
	Global.color_mode = false


func _on_color_mode_pressed() -> void:
	main.hide()
	color.show()
	Global.color_mode = true
