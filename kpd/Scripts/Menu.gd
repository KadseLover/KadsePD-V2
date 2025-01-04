extends PanelContainer

@onready var main: GridContainer = $Main
@onready var production: GridContainer = $Production
@onready var logistic: GridContainer = $Logistic
@onready var menu: Button = $"../Menu"

func _process(delta: float) -> void:
	pass

func _on_production_pressed() -> void:
	production.show()
	main.hide()


func _on_logistic_pressed() -> void:
	logistic.show()
	main.hide()

func _on_back_pressed() -> void:
	main.show()
	production.hide()

func _on_back_log_pressed() -> void:
	main.show()
	logistic.hide()

func _on_menu_pressed() -> void:
	show()
	menu.hide()

func _on_back_men_pressed() -> void:
	hide()
	menu.show()
