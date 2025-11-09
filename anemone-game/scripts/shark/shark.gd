class_name Shark
extends Node2D

@export var acceleration: float
@export var maxSpeed: float
@export var killDistance: float = 1400

@export var next_position_timer: Timer

@export var fish: Fish

var target: Player
var on_the_hunt: bool = true


func _process(_delta):
	# DIRTY check for collision with player
	if fish:
		var head_pos = fish.get_links().front().global_position
		# FIXME is global_position the right one here?
		var target_position = target.fish.get_links().front().global_position
		var distance_to_target = target_position.distance_to(head_pos)
		if distance_to_target < killDistance:
			if randf() < 0.5:
				AudioManager.play("sfx_bite_1")
			else:
				AudioManager.play("sfx_bite_2")
			print("YOU GOT EATEN BY SHARK")
			SignalBus.shark_bit.emit()
	
	if not on_the_hunt or not target:
		return
	if not target.is_hidden:
		if not next_position_timer.is_stopped():
			next_position_timer.stop()
		# FIXME maybe
		fish.target_position = target.fish.get_links().front().global_position
	elif next_position_timer.is_stopped():
		_target_random_point_on_map()
		next_position_timer.wait_time = 0
		next_position_timer.start()


func target_point(point: Vector2):
	fish.target_position = point


func _target_random_point_on_map():
	fish.target_position = Vector2(randf_range(0.0, GameConfig.map_size_x), randf_range(0.0, GameConfig.map_size_y))


func _on_random_clock_timeout() -> void:
	_target_random_point_on_map()
