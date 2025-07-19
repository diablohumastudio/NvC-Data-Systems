class_name Chest extends MoneyProvider

const _COIN_SCENE_PATH : String = "res://game_characters_scenes/components/ruble_coin/ruble_coin.tscn"
var spawned_coin : RubleCoin

func _spawn_new_coin():
	spawned_coin = load(_COIN_SCENE_PATH).instantiate() as RubleCoin

	self.add_child(spawned_coin)

	spawned_coin.timer_wait_time = 5.5
	spawned_coin.position = Vector2(-41, -135)

func _on_give_coin_anim_finished(_old_name: StringName, _new_name: StringName):
	_timer.wait_time = _get_coin_drop_wait_time()
	_timer.start()

func _on_timer_timeout():
	_animation_player.play("_give_coin")
	_animation_player.queue("_idle")
	await get_tree().create_timer(1).timeout
	_spawn_new_coin()
	await (_animation_player as AnimationPlayer).animation_changed
	_timer.wait_time = _get_coin_drop_wait_time()
	_timer.start()
