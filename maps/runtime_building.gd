extends Node

@onready var func_godot_map := $FuncGodotMap as FuncGodotMap

# We can connect the various build signals of the FuncGodotMap 
# in order to add more functionality after building.
func _ready():
	func_godot_map.connect("build_complete", _build_complete)
	func_godot_map.connect("build_failed", _build_failed)
	func_godot_map.local_map_file = "res://maps/example.map"
	func_godot_map.build()

func _build_complete() -> void:
	print("Map build successful!")

func _build_failed() -> void:
	printerr("Failed to build the map file! :(")
