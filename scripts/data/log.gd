## log.gd :: simple logging utility
class_name Log extends RefCounted


# Debugging
static var debug_level: DebugLevel = DebugLevel.VERB
static var debug_strings: Dictionary = {
	DebugLevel.ERR: "[color=#FF6060][b][ERROR][/b]: ",
	DebugLevel.WARN: "[color=#FFFF88][b][WARNING][/b]: ",
	DebugLevel.INFO: "[color=white][b][INFO][/b]: ",
	DebugLevel.VERB: "[color=gray][b][VERBOSE][/b]: "
}

enum DebugLevel { NONE, ERR, WARN, INFO, VERB }


# CORE ---------------------------------------------------------------

static func _ready() -> void:
	info("Engine physics tps: %s" % Engine.get_physics_ticks_per_second())


# DEBUG ---------------------------------------------------------------

## Compact debug logging function
static func _debug_log(severity: DebugLevel, message: String) -> void:
	if severity <= debug_level:
		print_rich(debug_strings[severity], message, "[/color]")

# Shorthand methods to call debug_log

## Errors (Fatal occurence)
## I.e. out of bounds, null reference, etc.
static func err(message: String) -> Error:
	_debug_log(DebugLevel.ERR, message)
	push_error(message)
	return ERR_BUG


## Warnings (Something unexpected)
## I.e. missing file, deprecated function, etc.
static func warn(message: String) -> void:
	_debug_log(DebugLevel.WARN, message)
	push_warning(message)


## General information logging
## I.e. scene loaded, button pressed
static func info(message: String) -> void:
	_debug_log(DebugLevel.INFO, message)


## Specific information logging
## I.e. variable values, number of objects
static func verb(message: String) -> void:
	_debug_log(DebugLevel.VERB, "[i]" + message + "[/i]")
