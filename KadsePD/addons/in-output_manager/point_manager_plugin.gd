@tool
extends EditorPlugin

var logo = preload("res://Assets/Anderes/Logo_plugin.svg")

func _enter_tree() -> void:
	add_custom_type("PointManager", "Node2D", preload("res://addons/in-output_manager/point_manager_node.gd"), logo)


func _exit_tree() -> void:
	remove_custom_type("PointManager")
