class_name ScAlly extends CharacterBody2D

var ally: Ally
var in_game_buyed_levels: Array[AllyLevel] = []

func _buy_level(level:AllyLevel):
	#in_game_buyed_levels.append(level)
	change_ally_scene_by_level(level)
	#modify_dependant_nodes()

func modify_dependant_nodes():
	var group_name = str(self)
	get_tree().call_group(group_name,"set_levels")

func initializate_at_base_level():
	_buy_level(ally.base_level)

func set_ally(_ally: Ally):
	ally = _ally
	%AllyUpgradeMenu.ally = ally

func change_ally_scene_by_level(level: AllyLevel):
	var new_ally_scene : ScAlly = level.scene.instantiate()
	disconnect_hud(self)

	self.name = "OldScAlly"
	new_ally_scene.name = "ScAlly"
	new_ally_scene.set_ally(ally)
	await _play_exit_animation()
	get_parent().add_child(new_ally_scene)
	self.queue_free()

	connect_hud(new_ally_scene)
	fix_ally_upgrade_menu_position(new_ally_scene)

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
	_buy_level(_level)

func fix_ally_upgrade_menu_position(sc_ally: ScAlly):
	var ally_HUD: Node = sc_ally.get_node("AllyHUD")
	var previous_pos = ally_HUD.global_position
	ally_HUD.top_level = true
	ally_HUD.global_position = previous_pos
	get_node("AllyHUD/AllyUpgradeMenu").global_position = Vector2(0,0)

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
