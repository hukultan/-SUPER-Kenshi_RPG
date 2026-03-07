## save.gd :: base resource for saves
@abstract
class_name Save extends Resource


const ROOT_DIR := "user://save"

var _stem: String = ""      # set by loader
var _global: bool = false    # set by loader
var loaded: bool = false

@export var last_write: float = -1.0 # unix timestamp of last modification


## Get the current save slot
static func _get_slot(global_scope: bool) -> String:
	if global_scope:
		return "glb"
	return GameState.current_slot


## Construct the savefile's path
static func _build_path(slot: String, stem: String) -> String:
	return "%s/%s.tres" % [ROOT_DIR, stem] if slot == "glb" else "%s/slot_%s/%s.tres" % [ROOT_DIR, slot, stem]


## Get this instances path
func path() -> String:
	if _stem == "":
		return ""
	var slot := _get_slot(_global)
	return "" if slot == "" else _build_path(slot, _stem)


## Write the current save data to file
func save() -> Error:
	if not GameState.current_slot:
		# Don't modify save data if we didn't load in properly (i.e. debuggin)
		return ERR_SKIP
	if _stem == "":
		return ERR_INVALID_PARAMETER
	var p := path()
	if p == "":
		return ERR_UNCONFIGURED
	if not FileAccess.file_exists(p) and loaded:
		return ERR_ALREADY_IN_USE
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(p.get_base_dir()))
	last_write = Time.get_unix_time_from_system()
	var err := ResourceSaver.save(self, p)
	if err == OK:
		loaded = true
	return err


## Fully delete a save slot
static func wipe_slot(slot: String) -> Error:
	if slot.is_empty():
		return ERR_INVALID_PARAMETER

	var root := "%s/slot_%s" % [ROOT_DIR, slot]
	if not DirAccess.dir_exists_absolute(root):
		return OK

	Log.warn("Wiping directory %s" % root)
	return _rm_rf(root)


## Recursively delete dir contents (DirAccess.remove only does empty dirs)
static func _rm_rf(dir_path: String) -> Error:
	# files
	for f in DirAccess.get_files_at(dir_path):
		var e := DirAccess.remove_absolute(dir_path.path_join(f))
		if e != OK:
			return e

	# subdirs
	for d in DirAccess.get_directories_at(dir_path):
		var sub := dir_path.path_join(d)
		var e := _rm_rf(sub)
		if e != OK:
			return e
		e = DirAccess.remove_absolute(sub)
		if e != OK:
			return e

	# remove this dir itself
	return DirAccess.remove_absolute(dir_path)


## Load save from disk, or instance a fresh copy
static func _load_impl(stem: String, global_scope: bool, cls: GDScript, hard_slot: String) -> Save:
	# Get the file path and load as a resource
	var slot := _get_slot(global_scope) if hard_slot == "" else hard_slot
	var p := _build_path(slot, stem)

	Log.info("Loading '%s', on slot %s" % [cls.get_global_name(), slot])

	# Load the file if its found
	if FileAccess.file_exists(p):
		Log.verb("Found save file at %s" % p)
		var r := ResourceLoader.load(p, "", ResourceLoader.CACHE_MODE_IGNORE)
		var sf := r as Save
		sf._stem = stem
		sf._global = global_scope
		sf.loaded = true
		return sf

	# File not found -- return instance
	Log.verb("No save file found at %s, returning instance" % p)
	var inst: Save = cls.new()
	inst._stem = stem
	inst._global = global_scope
	return inst
