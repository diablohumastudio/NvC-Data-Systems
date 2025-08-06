class_name DbugKillEnemiesHUD extends HBoxContainer

func _ready() -> void:
	UDS.listen_property(UDS.PROPERTIES.ENEMIES_KILLED, _update_kill_enemy_tot_label)
	_update_kill_enemy_tot_label()
	_update_kill_enemy_label()
	
func _update_kill_enemy_tot_label():
	%KillEnemyTotalLbl.text = str(UDS.get_property(UDS.PROPERTIES.ENEMIES_KILLED)) + " Enms Klld in Totl"

func _update_kill_enemy_label():
	%KillEnemyLbl.text = str(GSS.enemies_killed) + " Enms Klld in lvl"

func _on_kill_enemy_btn_pressed() -> void:
	GSS.enemies_killed += 1
	ACS.set_action(Action.new(Action.TYPES.ENEMY_KILLED, Action.PayEnemKilled.new(GSS.enemies_killed)))
	_update_kill_enemy_label()
