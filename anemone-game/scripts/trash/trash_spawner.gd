extends Node2D

@export var trash_scene := preload("res://scenes/trash/trash.tscn")
@export var spawn_delay := 1.0
@export var spawn_area_rect : Rect2

var cooldown := 1.0
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown <= 0:
		cooldown += spawn_delay
		spawn_trash()


func spawn_trash():
	var rand_x = rng.randf_range(-GameConfig.map_size_x / 2.0, GameConfig.map_size_x / 2.0)
	var rand_y = rng.randf_range(-GameConfig.map_size_y / 2.0, GameConfig.map_size_y / 2.0)
	var spawn_position = Vector2(rand_x, rand_y)
	print(str(rand_x) + ' ' + str(rand_y))
	
	var instance := trash_scene.instantiate() as Node2D
	instance.global_position = spawn_position
	add_child(instance)
	
