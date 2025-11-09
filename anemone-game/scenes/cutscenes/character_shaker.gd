class_name CharacterShaker
extends Node2D

@export var shake_strength: float = 20.0  # max distance from base position
@export var shake_speed: float = 0.1     # how fast to change position

var _base_position: Vector2

var _tween: Tween


func stop() -> void:
	_tween.stop()


func start() -> void:
	_do_shake()


func _ready():
	_base_position = position
	#_do_shake()  # start the shake loop


func _do_shake():
	_tween = create_tween()
	_tween.finished.connect(_do_shake)  # when done, start another one

	# choose a random offset in a circle
	var random_offset = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized() * randf_range(0, shake_strength)

	_tween.tween_property(
		self,
		"position",
		_base_position + random_offset,
		shake_speed
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
