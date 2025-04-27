extends Node

var g_tile_pos
var can_drag
var building
var laying
var delete_mode
var can_get_back
var text_focus
var building_focus
var new_text
var con_menu_mouse
var in_menu
var new_color
var AABB_
var selection_visible
var print_size
var print_name
var build_coords
var one_build_dragged
var cam_start_pos : Vector2i
var move_sensi = 20
var building_counter

var loaded_building_arr = []
var loaded_text_arr = []
var loaded_belt_arr = []


signal light_cancel_belt
signal light_cancel_pipe
signal change_text
signal change_color
signal AABB_hiden
signal cam_start_pos_finished
signal change_move_sensi
