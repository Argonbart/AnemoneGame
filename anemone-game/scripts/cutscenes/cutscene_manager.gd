extends Node2D

# Scene IDs
# 1 - phase_1
# 2 - phase_2
# 3 - phase_3
# 4 - win
# 5 - lose_shark
# 6 - lose_trash

@export var phase_1_scene: PackedScene
@export var phase_2_scene: PackedScene
@export var phase_3_scene: PackedScene
@export var win_scene: PackedScene
@export var lose_trash_scene: PackedScene
@export var lose_shark_scene: PackedScene

@export var gameplay_node: Node2D

var active_scene : Node2D = null

func _ready() -> void:
	SignalBus.begin_cutscene.connect(on_begin_cutscene)
	SignalBus.end_cutscene.connect(on_end_cutscene)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shortcut_1"):
		print("Start Cutscene 1")
		SignalBus.begin_cutscene.emit(1)
	if Input.is_action_just_pressed("shortcut_2"):
		SignalBus.begin_cutscene.emit(2)
	if Input.is_action_just_pressed("shortcut_3"):
		SignalBus.begin_cutscene.emit(3)
	if Input.is_action_just_pressed("shortcut_4"):
		SignalBus.begin_cutscene.emit(4)


func on_begin_cutscene(scene_id: int):
	if active_scene != null:
		return
	
	if scene_id == 1:
		active_scene = phase_1_scene.instantiate()
		#AudioManager.play("sad")
	elif scene_id == 2:
		active_scene = phase_2_scene.instantiate()
		AudioManager.stop_all_of_type(Sound.AudioType.MUSIC)
		AudioManager.play("middle")
	elif scene_id == 3:
		active_scene = phase_3_scene.instantiate()
		AudioManager.stop_all_of_type(Sound.AudioType.MUSIC)
		AudioManager.play("happy")
	elif scene_id == 4:
		active_scene = win_scene.instantiate()
	elif scene_id == 5:
		active_scene = lose_shark_scene.instantiate()
	elif scene_id == 6:
		active_scene = lose_trash_scene.instantiate()
		
	add_child(active_scene)
	await get_tree().create_timer(1.0).timeout
	gameplay_node.process_mode = Node.PROCESS_MODE_DISABLED


func on_end_cutscene():
	#active_scene.queue_free()
	active_scene = null
	gameplay_node.process_mode = Node.PROCESS_MODE_INHERIT
