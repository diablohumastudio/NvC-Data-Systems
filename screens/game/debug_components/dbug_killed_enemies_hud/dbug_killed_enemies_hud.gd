class_name DbugKillEnemiesHUD extends HBoxContainer

var enemies_killed: int = 0

func _ready() -> void:
	UDS.listen_property(UDS.PROPERTIES.ENEMIES_KILLED, _update_kill_enemy_tot_label)
	_update_kill_enemy_tot_label()
	_update_kill_enemy_label()
	
func _update_kill_enemy_tot_label():
	%KillEnemyTotalLbl.text = str(UDS.get_property(UDS.PROPERTIES.ENEMIES_KILLED)) + " Enms Klld in Totl"

func _update_kill_enemy_label():
	%KillEnemyLbl.text = str(enemies_killed) + " Enms Klld in lvl"

func _on_kill_enemy_btn_pressed() -> void:
	enemies_killed += 1
	ACS.set_action(Action.new(Action.TYPES.ENEMY_KILLED, Action.PayEnemKilled.new(enemies_killed)))
	_update_kill_enemy_label()
