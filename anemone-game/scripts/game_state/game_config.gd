extends Node

var map_size_x := 10_000.0
var map_size_y := 10_000.0
var map_half_size_x := map_size_x / 2.0
var map_half_size_y := map_size_y / 2.0
var fish_nav_screen_margin := 500.0

var phase_0_max_trash := 20
var phase_1_max_trash := 15
var phase_2_max_trash := 10
var phase_3_max_trash := 5

var trash_spawn_screen_marging := 3500.0
var trash_spawn_limit_x_left := -map_half_size_x + trash_spawn_screen_marging
var trash_spawn_limit_x_right := map_half_size_x - trash_spawn_screen_marging
var trash_spawn_limit_y_top := -map_half_size_y + trash_spawn_screen_marging
var trash_spawn_limit_y_bottom := map_half_size_y - trash_spawn_screen_marging

var phase_to_reach_for_win = 3


func _ready() -> void:
	print(map_size_x)
