@tool
class_name Link
extends Node2D


signal update

@export_category("Components")
@export var polygon_2d: Polygon2D
@export var line_2d: Line2D
@export var shape_point_container: Node2D

@export_category("Parameters")
@export var shape_points: Array[float]:
	set(value):
		shape_points = value
		update.emit()
@export_range(1.0, 100.0, 1.0) var radius: float = 64.0:
	set(value):
		radius = value
		update.emit()
@export var num_points: int = 32:
	set(value):
		num_points = value
		update.emit()
@export var fill_color: Color = Color.TRANSPARENT:
	set(value):
		fill_color = value
		update.emit()
@export var stroke_color: Color = Color.NAVY_BLUE:
	set(value):
		stroke_color = value
		update.emit()
@export_range(0.0, 100.0) var stroke_width: float = 4.0:
	set(value):
		stroke_width = value
		update.emit()

@export_tool_button("Draw") var draw_action = draw
@export_tool_button("Update Shape Points") var update_shape_points_action = _update_shape_points

# Member variables
# Public variables
@export var next: Link
# Private variables
var _points: Array[Vector2]


func _init() -> void:
	shape_points.append(0.25)
	shape_points.append(0.75)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func get_shape_points() -> Array[Vector2]:
	var dir_vector = Vector2.RIGHT
	if next:
		dir_vector = next.global_position - self.global_position
	var new_rotation = Vector2.RIGHT.angle_to(dir_vector)
	shape_point_container.rotation = new_rotation
	var shape_point_positions: Array[Vector2]
	for point: Node2D in shape_point_container.get_children():
		shape_point_positions.append(point.global_position)
	return shape_point_positions


func draw() -> void:
	_calculate_points()
	_draw_fill()
	_draw_stroke()
	_update_shape_points()


func _calculate_points() -> void:
	_points.clear()
	for i in range(num_points):
		var angle: float = (2 * PI / num_points) * i
		var new_point: Vector2 = Vector2(radius * cos(angle), radius * sin(angle))
		_points.append(new_point)


func _update_shape_points() -> void:
	for child in shape_point_container.get_children():
		child.free()
	for point: float in shape_points:
		var angle = remap(point, 0.0, 1.0, 0.0, 2 * PI)
		var point_viz: ShapePoint = ShapePoint.new()
		point_viz.position = Vector2(radius * cos(angle), radius * sin(angle))
		shape_point_container.add_child(point_viz)
		point_viz.owner = self


func _draw_fill() -> void:
	polygon_2d.color = fill_color
	polygon_2d.polygon = _points


func _draw_stroke() -> void:
	line_2d.width = stroke_width
	line_2d.default_color = stroke_color
	line_2d.points = _points
