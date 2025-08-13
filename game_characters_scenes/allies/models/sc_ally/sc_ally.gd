class_name ScAlly extends CharacterBody2D

var ally: Ally
var level: AllyLevel: set = _set_level
var group_name: String
var levels: Array[AllyLevel] = []

func _set_level(new_value: AllyLevel):
	level = new_value 
	var new_ally_scene : ScAlly = level.scene.instantiate()
	disconnect_hud(self)
	await change_ally_scene(new_ally_scene)
	connect_hud(new_ally_scene)
	fix_ally_upgrade_menu_position(new_ally_scene)
	new_ally_scene.set_ally(ally)

func set_ally(_ally: Ally):
	ally = _ally
	%AllyUpgradeMenu.ally = ally

func connect_hud(sc_ally: ScAlly):
	sc_ally.get_node("%AllyUpgradeMenu").level_changed.connect(sc_ally.on_ally_upgrade_menu_level_changed)
	sc_ally.get_node("%SelectAllyBtn").pressed.connect(sc_ally.on_select_ally_btn_pressed)

func disconnect_hud(sc_ally: ScAlly):
	if sc_ally.get_node("%AllyUpgradeMenu").level_changed.is_connected(sc_ally.on_ally_upgrade_menu_level_changed):
		sc_ally.get_node("%AllyUpgradeMenu").level_changed.disconnect(sc_ally.on_ally_upgrade_menu_level_changed)
	if sc_ally.get_node("%SelectAllyBtn").pressed.is_connected(sc_ally.on_select_ally_btn_pressed):
		sc_ally.get_node("%SelectAllyBtn").pressed.disconnect(sc_ally.on_select_ally_btn_pressed)

func on_select_ally_btn_pressed():
	if GSS.removing_ally_state: 
		self.queue_free()
		GSS.removing_ally_state = false
	else: %AllyUpgradeMenu.visible = true

func on_ally_upgrade_menu_level_changed(_level: AllyLevel):
	level = _level

func fix_ally_upgrade_menu_position(sc_ally: ScAlly):
	var ally_HUD: Node = sc_ally.get_node("AllyHUD")
	var previous_pos = ally_HUD.global_position
	ally_HUD.top_level = true
	ally_HUD.global_position = previous_pos

func change_ally_scene(new_sc_ally: ScAlly):
	self.name = "OldScAlly"
	new_sc_ally.name = "ScAlly"
	await _play_exit_animation()
	get_parent().add_child(new_sc_ally)
	
	self.queue_free()
	return

func _play_exit_animation():
	var has_animation_player: bool = has_node("StateAnimationPlayer") 
	var anim_playaer_has_go_out: bool 
	if has_animation_player:
		anim_playaer_has_go_out = (get_node("StateAnimationPlayer") as AnimationPlayer).has_animation("go_out")
	if !has_animation_player or !anim_playaer_has_go_out: 
		await get_tree().create_timer(.1).timeout
		return
	$StateAnimationPlayer.play("go_out")
	await ($StateAnimationPlayer as AnimationPlayer).animation_finished
