extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	print('drop zone: ' + str(_body))
	SignalBus.trash_dropped.emit()
	if randf() < 0.333333:
		AudioManager.play("sfx_suck_in")
	elif randf() < 0.33333:
		AudioManager.play("sfx_suck_in_1")
	else:
		AudioManager.play("sfx_suck_in_2")
