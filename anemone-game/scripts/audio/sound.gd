@tool
class_name Sound
extends Resource


enum AudioType {
	MUSIC,
	SFX,
	DIALOGUE
}

@export var audio: Resource:
	set(value):
		if value:
			audio = value
			name = audio.resource_path.get_file().get_slice(".", 0)
@export var name: String
@export var character: String
@export_multiline var text: String
@export var type: AudioType
@export_range(0.0, 1.0, 0.1) var volume: float = 1.0
@export_range(0.0, 1.0, 0.1) var pitch: float = 1.0
@export var loop: bool = false
