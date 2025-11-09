class_name Player
extends StaticBody2D


@export_category("Components")
@export var fish: Fish

# Trash variables
var trash_collected_scn = preload("res://scenes/trash/trash_collected.tscn")
var current_trash: Node2D = null
var amount_of_trash_collected := 0


func _ready() -> void:
	SignalBus.trash_collected.connect(collect_trash)
	SignalBus.trash_dropped.connect(drop_all_trash)


func _physics_process(_delta: float) -> void:
	var desired_pos: Vector2 = get_global_mouse_position()
	fish.target_position = desired_pos


func collect_trash():
	print("TRASH COLLECTED")
	amount_of_trash_collected = amount_of_trash_collected + 1
	if current_trash == null:
		var trash = trash_collected_scn.instantiate()
		$TrashPosition.add_child(trash)
		current_trash = trash


func drop_all_trash():
	print('dropped ' + str(amount_of_trash_collected) + ' trash')
	amount_of_trash_collected = 0
	if current_trash != null:
		current_trash.queue_free()
