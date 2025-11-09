extends Node2D


@export var ane: CharacterShaker
@export var bel: CharacterShaker
@export var sam: CharacterShaker
@export var fio: CharacterShaker
@export var may: CharacterShaker

@export var price: Sprite2D


func _ready() -> void:
	price.scale = Vector2.ZERO
	
	bel.start()
	AudioManager.play_dialogue("vocal_4_001").finished.connect((func():
		AudioManager.play_dialogue("vocal_4_002").finished.connect((func():
			bel.stop()
			ane.start()
			_show_price()
			AudioManager.play_dialogue("vocal_4_003").finished.connect((func():
				await get_tree().create_timer(2.0).timeout
				get_parent().get_parent().close_cutscene()
			))
		))
	))


func _show_price() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(price, "scale", Vector2.ONE * .5, 2.0)\
		.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(price, "scale", Vector2.ZERO, 1.0)
