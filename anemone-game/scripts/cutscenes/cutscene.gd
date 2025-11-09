extends Node


@export var cutscene_id: int

var remaining_time = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('START CUTSCENE')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	remaining_time -= delta
	print('remaining_time = ' + str(remaining_time))
	if remaining_time <= 0.0:
		SignalBus.end_cutscene.emit()
		print('END CUTSCENE')
		queue_free()
