extends Node


signal dialogue_finished(last_dialogue)

@export var sounds: Array[Sound] = []
@export var caption: RichTextLabel
@export var canvas_layer: CanvasLayer

var master_volume: float = .5
var music_volume: float = .5
var sfx_volume: float = .5
var dialogue_volume: float = .5

var dialogue_queue: Array[String]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		skip_current_cutscene()


func play(s_name: String) -> AudioStreamPlayer:
	# Get sound by name
	var s: Sound = sounds.filter(func(sound) -> bool: return sound.name == s_name).front()
	if not s:
		printerr("Error: No sound with name \"" + s_name + "\" found")
		return
	
	# Create audio stream player
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	# Put caption if available
	if not s.text.is_empty():
		caption.text = "[outline_size=16]" + "[outline_color=#000000]" + "[center]" + s.text + "[/center]" + "[/outline_color]" + "[/outline_size]"
		player.finished.connect((func(): caption.text = ""))
	# Apply sound settings
	player.stream = s.audio
	player.volume_db = linear_to_db(s.volume)
	player.pitch_scale = s.pitch
	match s.type:
		Sound.AudioType.MUSIC:
			player.bus = "music"
		Sound.AudioType.SFX:
			player.bus = "sfx"
		Sound.AudioType.DIALOGUE:
			player.bus = "dialogue"
	if s.loop:
		player.finished.connect(
			func(): 
				self.play(s.name)
				player.queue_free()
		)
	else:
		player.finished.connect(
			func(): 
				player.queue_free()
		)
	
	# Play audio
	self.add_child(player)
	player.play()
	
	# Return audio stream player
	return player


func play_dialogue(dialogue_names: Array[String]) -> void:
	 # Cancel all playing dialogues
	stop_all_of_type(Sound.AudioType.DIALOGUE)
	if dialogue_names.size() < 1:
		return
	for dialogue_name: String in dialogue_names:
		await self.play(dialogue_name).finished
	dialogue_finished.emit(dialogue_names[dialogue_names.size() - 1])


func skip_current_cutscene() -> void:
	
	var dialogue_list = []
	
	for child in get_children():
		if child == canvas_layer:
			continue
		if child is not AudioStreamPlayer:
			print("A non-audio file under AudioManager detected!")
			return
		if child.stream.resource_path.contains("music"):
			continue
		if child.stream.resource_path.contains("dialogue"):
			dialogue_list.append(child)
	
	if not dialogue_list.is_empty():
		var next_dialogue = dialogue_list[0]
		next_dialogue.finished.emit()
		next_dialogue.stop()
		next_dialogue.queue_free()


func stop_all() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			child.queue_free()


func stop_all_of_type(type: Sound.AudioType) -> void:
	for child in get_children():
		if child is not AudioStreamPlayer:
			continue
		var bus_name: String = child.bus
		match type:
			Sound.AudioType.MUSIC:
				if bus_name == "music":
					child.stop()
					child.queue_free()
			Sound.AudioType.SFX:
				if bus_name == "sfx":
					child.stop()
					child.queue_free()
			Sound.AudioType.DIALOGUE:
				if bus_name == "dialogue":
					child.stop()
					child.queue_free()
