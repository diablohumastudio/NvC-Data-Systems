class_name ResourceProvider extends ScAlly

var coin_pksc : PackedScene = load("res://game_characters_scenes/components/ruble_coin/ruble_coin.tscn")
const _DROPING_ANIMATION_TIME_TO_SHOW_COIN: float = 1.0
var spawned_coin : RubleCoin

@export var resource_value: int
@export var seconds_per_coin: float

var is_currently_playing: bool = false

func _ready() -> void:
	%CoinDropTimer.wait_time = _get_coin_drop_wait_time()
	(%CoinDropTimer as Timer).timeout.connect(_on_coin_drop_timer_timeout)
	%CoinDropTimer.start()

func _get_coin_drop_wait_time() -> float:
	var random_number_generator := RandomNumberGenerator.new()
	var random_int : float = float (random_number_generator.randi_range(-5, 5)) / 10

	var wait_time: float = seconds_per_coin + random_int
	return wait_time

func _on_coin_drop_timer_timeout() -> void:
	if is_currently_playing: return
	is_currently_playing = true
	%StateAnimationPlayer.play("_giving_coin")
	%StateAnimationPlayer.queue("_idle")
	await (%StateAnimationPlayer as AnimationPlayer).animation_changed
	%CoinDropTimer.wait_time = _get_coin_drop_wait_time()
	%CoinDropTimer.start()
	is_currently_playing= false

func _spawn_coin():
	spawned_coin = coin_pksc.instantiate() as RubleCoin
	spawned_coin.timer_wait_time = 2.0 if seconds_per_coin > 4 else 1
	spawned_coin.position = Vector2(-41, -135)
	self.add_child(spawned_coin)
