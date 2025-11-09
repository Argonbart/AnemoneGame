extends Node

signal trash_spawned(has_replaced_decaying_trash: bool)
signal trash_collected(trash: Trash)
signal trash_dropped()
signal trash_decayed()
signal microplastics_pollution_changed()
signal anemome_entered()
signal anemone_exited()
signal protection_gained()
signal protection_lost()
signal shark_bit()
signal replace_decayed_trash()
signal update_total_trash_in_game()
signal begin_cutscene(scene_id: int)
signal end_cutscene()


func _ready() -> void:
	trash_spawned.get_name()
	trash_collected.get_name()
	trash_dropped.get_name()
	trash_decayed.get_name()
	microplastics_pollution_changed.get_name()
	anemome_entered.get_name()
	anemone_exited.get_name()
	protection_gained.get_name()
	protection_lost.get_name()
	shark_bit.get_name()

# TODO: Add information about collected/dropped trash
