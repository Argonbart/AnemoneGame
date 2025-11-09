extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.stop_all()
	AudioManager.play("sad")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
