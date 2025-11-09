extends Node


@export var cutscene_id: int


func close_cutscene() -> void:
	SignalBus.end_cutscene.emit()
	queue_free()
