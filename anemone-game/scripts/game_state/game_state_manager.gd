extends Node

var trash_carried := 0
var trash_on_map := 0
var anemone_protecting_count := 0
var current_micro_plastic_pollution := 0
var max_micro_plastic_pollution := 5
var total_trash_in_game := 0

var current_game_phase := 0 # 0, 1, 2, 3


func _ready() -> void:
	SignalBus.trash_collected.connect(_on_trash_collected)
	SignalBus.trash_dropped.connect(_on_trash_dropped)
	SignalBus.trash_decayed.connect(_on_trash_decayed)
	SignalBus.anemome_entered.connect(_on_anemone_entered)
	SignalBus.anemone_exited.connect(_on_anemone_exited)
	SignalBus.trash_spawned.connect(_on_trash_spawned)


func is_player_carrying_trash() -> bool:
	return trash_carried > 0


func _on_trash_collected(_trash: Trash):
	trash_carried += 1
	print('trash carried = ' + str(trash_carried))


func _on_trash_dropped():
	if (trash_carried > 0):
		print('dropped. trash carried = ' + str(trash_carried))
		total_trash_in_game -= trash_carried
		trash_carried = 0
		check_phase_progression()


func _on_anemone_entered():
	if anemone_protecting_count < 1:
		SignalBus.protection_gained.emit()
	anemone_protecting_count += 1


func _on_anemone_exited():
	anemone_protecting_count -= 1
	if anemone_protecting_count == 0:
		SignalBus.protection_lost.emit()


func _on_trash_decayed():
	#total_trash_in_game -= 1
	SignalBus.replace_decayed_trash.emit()
	current_micro_plastic_pollution += 1
	SignalBus.microplastics_pollution_changed.emit()
	if current_micro_plastic_pollution >= max_micro_plastic_pollution:
		#print('YOU LOST')
		pass


func _on_trash_spawned(has_replaced_decaying_trash: bool):
	if !has_replaced_decaying_trash:
		total_trash_in_game += 1
		SignalBus.update_total_trash_in_game.emit()


func check_phase_progression():
	if current_game_phase == 0:
		if total_trash_in_game < GameConfig.phase_1_max_trash:
			begin_phase(1)
	elif current_game_phase == 1:
		if total_trash_in_game < GameConfig.phase_2_max_trash:
			begin_phase(2)
	elif current_game_phase == 2:
		if total_trash_in_game < GameConfig.phase_3_max_trash:
			begin_phase(3)
	elif current_game_phase == 3:
		if total_trash_in_game <= 0:
			begin_phase(4)


func begin_phase(phase_id: int):
	current_game_phase = phase_id
	SignalBus.begin_phase.emit(phase_id)
	print('next phase is ' + str(phase_id))
	if (phase_id == GameConfig.phase_to_reach_for_win):
		win_game()
	else:
		SignalBus.begin_cutscene.emit(phase_id)


func win_game():
	print('WON')
	SignalBus.begin_cutscene.emit(CutsceneConfig.CUTSCENE_WIN_ID)


func is_map_too_full() -> bool:
	if current_game_phase == 0:
		return total_trash_in_game >= GameConfig.phase_0_max_trash
	elif current_game_phase == 1:
		return total_trash_in_game >= GameConfig.phase_1_max_trash
	elif current_game_phase == 2:
		return total_trash_in_game >= GameConfig.phase_2_max_trash
	elif current_game_phase == 3:
		return total_trash_in_game >= GameConfig.phase_3_max_trash
	return false
