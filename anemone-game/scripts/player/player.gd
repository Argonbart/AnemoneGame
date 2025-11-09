class_name Player
extends StaticBody2D


@export_category("Components")
@export var fish: Fish

@export_category("Movement Parameters")
@export var speed: float = 600.0
@export var max_turn_deg_per_sec: float = 180.0

# Movement variables
var velocity: Vector2 = Vector2.RIGHT * speed
var target_pos: Vector2

# Trash variables
var trash_collected_scn = preload("res://scenes/trash/trash_collected.tscn")
var current_trash: Node2D = null
var amount_of_trash_collected := 0


func _ready() -> void:
	SignalBus.trash_collected.connect(collect_trash)
	SignalBus.trash_dropped.connect(drop_all_trash)
	
	# Movement
	target_pos = get_global_mouse_position()


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var head: Link = fish.get_links().front()
	
	var desired_pos: Vector2 = get_global_mouse_position()
	
	# Smooth steering with limited angular speed
	var to_target = desired_pos - head.global_position
	if to_target.length_squared() < 0.0001:
		head.global_position += velocity * delta
		return
	
	var desired_angle = to_target.angle()
	var current_angle = velocity.angle()
	var angle_diff = wrapf(desired_angle - current_angle, -PI, PI)
	var max_turn = deg_to_rad(max_turn_deg_per_sec) * delta
	var clamped_turn = clamp(angle_diff, -max_turn, max_turn)
	var new_angle = current_angle + clamped_turn
	
	velocity = Vector2.RIGHT.rotated(new_angle) * speed
	head.look_at(head.global_position + velocity)
	head.global_position += velocity * delta
	
	var body: Array[Node] = fish.get_links().slice(1)
	for link: Link in body:
		if link.global_position.distance_to(link.next.global_position) > fish.link_distance:
			var reversed_direction = link.global_position - link.next.global_position
			var new_pos = link.next.global_position + reversed_direction.normalized() * fish.link_distance
			link.global_position = new_pos
	
	fish.redraw()


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
