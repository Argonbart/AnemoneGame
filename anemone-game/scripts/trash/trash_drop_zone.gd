extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	print('drop zone: ' + str(_body))
	SignalBus.trash_dropped.emit()
