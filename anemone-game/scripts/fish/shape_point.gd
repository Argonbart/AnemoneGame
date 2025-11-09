@tool
class_name ShapePoint
extends Polygon2D


@export var radius: float = 2.0
@export var num_points: int = 16


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color.FIREBRICK
	draw()


func draw() -> void:
	var new_points: Array[Vector2]
	for i in range(num_points):
		var angle = (2 * PI / num_points) * i
		new_points.append(Vector2(radius * cos(angle), radius * sin(angle)))
	self.polygon = new_points
