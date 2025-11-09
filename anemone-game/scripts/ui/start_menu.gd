extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_level.tscn")


func _on_button_credits_pressed() -> void:
	$CanvasLayer/CanvasLayer.visible = true


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$CanvasLayer/CanvasLayer.visible = false
		print('close credits')
