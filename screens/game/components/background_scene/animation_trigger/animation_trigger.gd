class_name AnimationTrigger extends Node

enum ANIMATION_TYPES {
	INITIAL_STATE,
	FIRST_WAVE_STARTED,
	LAST_WAVE_STARTED,
	OTHER_ACTION_ACTIVATED,
	COUNTER_REACH_FIVE
}

signal animation_triggered(animation_type: ANIMATION_TYPES)

func _ready() -> void:
	self.add_to_group("animation_trigger")

func trigger_animation(type: ANIMATION_TYPES):
	animation_triggered.emit(type)
