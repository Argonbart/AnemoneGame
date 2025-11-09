extends Node2D


@export var ane: CharacterShaker
@export var other: CharacterShaker

@export var price: Sprite2D


func _ready() -> void:
	price.scale = Vector2.ZERO
	
	other.start()
	AudioManager.play_dialogue("vocal_7_001").finished.connect((func():
		_show_price()
		AudioManager.play_dialogue("vocal_7_002").finished.connect((func():
			other.stop()
			ane.start()
			AudioManager.play_dialogue("vocal_7_003").finished.connect((func():
				ane.stop()
				await get_tree().create_timer(2.0).timeout
				get_parent().close_cutscene()
			))
		))
	))


func _show_price() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(price, "scale", Vector2.ONE * .5, 2.0)\
		.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(price, "scale", Vector2.ONE * .5, 1.0)
	tween.tween_property(price, "scale", Vector2.ZERO, 1.0)
