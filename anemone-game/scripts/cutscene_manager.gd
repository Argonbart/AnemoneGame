extends Node2D


@export var phase_1_scene: PackedScene
@export var phase_2_scene: PackedScene
@export var phase_3_scene: PackedScene
@export var win_scene: PackedScene
@export var lose_trash_scene: PackedScene
@export var lose_shark_scene: PackedScene

var active_scene : Node2D = null


func _ready() -> void:
	SignalBus.begin_cutscene.connect(on_begin_cutscene)
	SignalBus.end_cutscene.connect(on_end_cutscene)


func on_begin_cutscene(scene_id: int):
	if active_scene != null:
		return
	
	if scene_id == 1:
		active_scene = phase_1_scene.instantiate()
	elif scene_id == 2:
		active_scene = phase_2_scene.instantiate()
	elif scene_id == 3:
		active_scene = phase_2_scene.instantiate()
	elif scene_id == 4:
		active_scene = phase_2_scene.instantiate()


func on_end_cutscene():
	pass
