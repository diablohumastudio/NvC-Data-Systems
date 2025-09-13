class_name DbugTriggerAnimationBtn extends Button

func _ready() -> void:
	for type in AnimationTrigger.ANIMATION_TYPES.keys():
		%AnimationTypesOptBtn.add_item(type)

func _on_pressed() -> void:
	var selected_index: int = %AnimationTypesOptBtn.selected
	var anim_type_string: String = %AnimationTypesOptBtn.get_item_text(selected_index)
	var anim_type: AnimationTrigger.ANIMATION_TYPES = AnimationTrigger.ANIMATION_TYPES[anim_type_string]
	%AnimationTrigger.trigger_animation(anim_type)
