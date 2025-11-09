extends Sprite2D

const RAINBOW = preload("uid://cqxmummarc7mq")

func _ready():
	var random_value = randf_range(0.0, 2.0 * PI)
	var new_material = ShaderMaterial.new()
	new_material.shader = RAINBOW
	material = new_material
	material.set_shader_parameter("start_offset", random_value)
