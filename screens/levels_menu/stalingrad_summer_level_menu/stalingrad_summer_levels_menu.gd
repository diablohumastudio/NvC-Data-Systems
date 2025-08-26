class_name StalingradSummerLevelsMenu extends Control

var entering_from_stalingrad_summer_camp: bool = false

func _ready() -> void:
	if entering_from_stalingrad_summer_camp:
		%GotoCampAnimationPlayer.play("goto_stalingrad_summer_camp", -1, -1, true)

func _on_go_back_button_pressed() -> void:
	AudioSystem.post_event(AK.EVENTS.PLAY_GO_BACK)
	var worlds_map_menu: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.WORLDS_MAP_MENU)
	%InitialAnimationPlayer.play("start", 1, -0.3, true)
	await get_tree().create_timer(1).timeout
	SMS.change_scene(worlds_map_menu, {"entering_from_salingrad_summer_levels_menu": true})

func _on_goto_stalingrad_summer_camp_button_pressed() -> void:
	var stalingrad_summer_camp: PackedScene = SLS.get_scene(GC.SCREENS_UIDS.STALINGRAD_SUMMER_CAMP)
	%GotoCampAnimationPlayer.play("goto_stalingrad_summer_camp")
	await %GotoCampAnimationPlayer.animation_finished
	SMS.change_scene(stalingrad_summer_camp)
