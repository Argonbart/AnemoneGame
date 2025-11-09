extends Node

var map_size_x := 10_000.0
var map_size_y := 10_000.0
var map_half_size_x := map_size_x / 2.0
var map_half_size_y := map_size_y / 2.0
var fish_nav_screen_margin := 500.0

var cleaning_progression_1 := 0.8
var cleaning_progression_2 := 0.5
var cleaning_progression_3 := 0.2

var trash_spawn_screen_marging := 500.0
var trash_spawn_limit_x_left := -map_half_size_x + trash_spawn_screen_marging
var trash_spawn_limit_x_right := map_half_size_x - trash_spawn_screen_marging
var trash_spawn_limit_y_top := -map_half_size_y + trash_spawn_screen_marging
var trash_spawn_limit_y_bottom := map_half_size_y - trash_spawn_screen_marging


func _ready() -> void:
	print(map_size_x)
