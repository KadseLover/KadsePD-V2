extends PanelContainer

@onready var main: GridContainer = $Main
@onready var production: GridContainer = $Production
@onready var logistic: GridContainer = $Logistic
@onready var menu: Button = $"../Menu"
@onready var menu_name: Label = $"../LabelDings/Menu Name"
@onready var label_dings: PanelContainer = $"../LabelDings"

func _process(delta: float) -> void:
	pass

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


func _on_text_pressed() -> void:
	pass # Replace with function body.
