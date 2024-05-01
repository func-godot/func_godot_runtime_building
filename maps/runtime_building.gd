extends Node

@onready var func_godot_map := $FuncGodotMap as FuncGodotMap

# We can connect the various build signals of the FuncGodotMap 
# in order to add more functionality after building.
func _ready():
	func_godot_map.connect("build_complete", _build_complete)
	func_godot_map.connect("build_failed", _build_failed)
	func_godot_map.connect("unwrap_uv2_complete", _unwrap_uv2_complete)
	func_godot_map.verify_and_build()

# We need to wait for the build to finish before unwrapping mesh UV2s for lightmap baking.
# Currently lightmap baking cannot be performed at runtime, so it's not terribly useful yet.
# Consider creating a procedural Voxel GI solid class entity that can be baked at runtime instead.
func _build_complete() -> void:
	print("Success! Unwrapping UV2...")
	func_godot_map.unwrap_uv2()

func _build_failed() -> void:
	printerr("Failed to build the map file! :(")

func _unwrap_uv2_complete() -> void:
	print("UV2 unwrapping completed!")
