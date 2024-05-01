class_name GameManager
extends Node

# Common inverse scale. Calculated as 1.0 / Inverse Scale Factor. 
# Used to help translate properties using Quake Units into Godot Units.
const INVERSE_SCALE: float = 0.03125

enum {
	WORLD_LAYER = (1 << 0),
	ACTOR_LAYER = (1 << 1),
	TRIGGER_LAYER = (1 << 2)
}

func use_targets(activator: Node, target: String) -> void:
	# Targetnames are really Godot Groups, so we can have multiple entities 
	# share a common "targetname" in Trenchbroom.
	var target_list: Array[Node] = get_tree().get_nodes_in_group(target)
	for targ in target_list:
		var f: String
		# Be careful when specifying a function since we can't pass arguments 
		# to it (without hackarounds of course)
		if 'targetfunc' in activator:
			f = activator.targetfunc
		if f.is_empty():
			f = "use"
		if targ.has_method(f):
			targ.call(f)

func set_targetname(node: Node, targetname: String) -> void:
	if node != null and not targetname.is_empty():
		node.add_to_group(targetname)

# Converts Quake 1 axis to Godot axis
static func id_vec_to_godot_vec(vec: Variant)->Vector3:
	var org: Vector3 = Vector3.ZERO
	if vec is Vector3:
		org = vec
	elif vec is String:
		var arr: PackedFloat64Array = (vec as String).split_floats(" ")
		for i in max(arr.size(), 3):
			org[i] = arr[i]
	return Vector3(org.y, org.z, org.x)
