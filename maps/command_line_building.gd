extends Node

@onready var func_godot_map := $FuncGodotMap as FuncGodotMap

func _ready():
	# We want to loop through each command line argument until we find 
	# our "run_map" argument. This argument will be split using :: as a delimiter,
	# giving us a two element array with the second element being our map's path.
	for cmdline_arg in OS.get_cmdline_user_args():
		if cmdline_arg.contains("run_map::"):
			var arg_arr := cmdline_arg.split("::")
			
			# Safety check to make sure we didn't mess up our command line arguments.
			# We should have a String array with [argument command, argument value].
			if arg_arr.size() != 2:
				return
			
			# Apply the argument value to our map node and build!
			$Label.text = arg_arr[1]
			func_godot_map.local_map_file = arg_arr[1]
			func_godot_map.verify_and_build()
