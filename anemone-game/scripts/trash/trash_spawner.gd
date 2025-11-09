extends Node2D

@export var trash_scene := preload("res://scenes/trash/trash.tscn")
@export var spawn_delay := 1.0
@export var spawn_area_rect : Rect2

var cooldown := 1.0
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.replace_decayed_trash.connect(on_replace_decayed_trash)
	while can_spawn():
		spawn_trash()
		SignalBus.trash_spawned.emit(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown <= 0:
		if can_spawn():
			spawn_trash()
			SignalBus.trash_spawned.emit(false)
			cooldown = spawn_delay


func can_spawn() -> bool:
	return !GameStateManager.is_map_too_full()


func spawn_trash():
	var rand_x = rng.randf_range(GameConfig.trash_spawn_limit_x_left, GameConfig.trash_spawn_limit_x_right)
	var rand_y = rng.randf_range(GameConfig.trash_spawn_limit_y_top, GameConfig.trash_spawn_limit_y_bottom)
	var spawn_position = Vector2(rand_x, rand_y)
	#print(str(rand_x) + ' ' + str(rand_y))
	
	var instance := trash_scene.instantiate() as Node2D
	instance.global_position = spawn_position
	add_child(instance)


func on_replace_decayed_trash():
	spawn_trash()
	SignalBus.trash_spawned.emit(true)
