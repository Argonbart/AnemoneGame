@tool
extends Node2D


const FISH_LINK = preload("uid://b8kv0npx7hj7a")
const FISH_LENGTH: int = 5
const FISH_LINK_RADIUS: float = 20.0

@export_tool_button("Generate fish form") var generate_fish_form_button = generate_fish

@export_category("Components")
@export var fish_outline: Line2D

var _fish_links: Array[FishLink]


func _ready():
	generate_fish()


func generate_fish():
	
	_fish_links.clear()
	for child in get_children():
		if child.is_in_group("fish_link"):
			child.free()
	
	var fish_length = 0.0
	for link_index in range(FISH_LENGTH):
		var new_link: FishLink = FISH_LINK.instantiate()
		new_link.add_to_group("fish_link")
		new_link.radius = FISH_LINK_RADIUS
		new_link.position = Vector2(fish_length, 0.0)
		fish_length = fish_length + new_link.radius
		self.add_child(new_link)
		new_link.owner = self
		if link_index == 0:
			new_link.is_tail = true
			# SET new_link.tail_points
		if link_index == FISH_LENGTH - 1:
			new_link.is_head = true
			# SET new_link.head_points
		_fish_links.append(new_link)
	for link_index in range(_fish_links.size()):
		var link = _fish_links[link_index]
		if not link.is_head:
			link.next = _fish_links[link_index + 1]
	draw_outline()


func _process(delta):
	
	var head: FishLink = _fish_links[_fish_links.size() - 1]
	var tail: FishLink = _fish_links[0]
	var targetPos = get_viewport().get_mouse_position()
	var headPos = head.global_position
	var headDir = (targetPos - headPos).normalized()
	
	# TODO: Add turning constraint
	
	headPos += headDir * delta * 400.0
	if (targetPos - headPos).length() > 5.0:
		head.update_head(headPos, headDir)
		tail.update_tail()
	
	draw_outline()

func draw_outline():
	
	var outline_points = []
	var left_points = []
	var right_points = []
	var head_points = []
	var tail_points = []
	
	for link in _fish_links:
		if link == _fish_links[0]:
			tail_points = link.tail_points
			continue
		if link == _fish_links[_fish_links.size() - 1]:
			head_points = link.head_points
		left_points.append(link.left_point)
		right_points.append(link.right_point)
	
	for point in left_points:
		outline_points.append(point)
	for point in head_points:
		outline_points.append(point)
	right_points.reverse()
	for point in right_points:
		outline_points.append(point)
	for point in tail_points:
		outline_points.append(point)
	
	fish_outline.points = outline_points
